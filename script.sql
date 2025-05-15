CREATE DATABASE IF NOT EXISTS toiletview DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_0900_ai_ci;

-- Todos os deltas estão em segundos

USE toiletview;

-- topic v3/espm/devices/presence01/up
-- topic v3/espm/devices/presence02/up
-- topic v3/espm/devices/presence03/up
-- topic v3/espm/devices/presence04/up
-- topic v3/espm/devices/presence05/up
-- topic v3/espm/devices/presence06/up
-- topic v3/espm/devices/presence07/up
-- topic v3/espm/devices/presence08/up
-- { "end_device_ids": { "device_id": "presence01" }, "uplink_message": { "rx_metadata": [{ "timestamp": 2040934975 }], "decoded_payload": { "battery": 99, "occupancy": "vacant" } } }
CREATE TABLE presenca (
  id bigint NOT NULL,
  data datetime NOT NULL,
  id_sensor tinyint NOT NULL,
  delta int NOT NULL,
  bateria tinyint NOT NULL,
  ocupado tinyint NOT NULL,
  PRIMARY KEY (id),
  KEY presenca_data_id_sensor (data, id_sensor),
  KEY presenca_id_sensor (id_sensor)
);

-- topic v3/espm/devices/odor01/up
-- topic v3/espm/devices/odor02/up
-- { "end_device_ids": { "device_id": "odor01" }, "uplink_message": { "rx_metadata": [{ "timestamp": 2040934975 }], "decoded_payload": { "battery": 99, "h2s": 0.02, "humidity": 78, "nh3": 0.01, "temperature": 24.3 } } }
CREATE TABLE odor (
  id bigint NOT NULL AUTO_INCREMENT,
  data datetime NOT NULL,
  id_sensor tinyint NOT NULL,
  delta int NOT NULL,
  bateria tinyint NOT NULL,
  h2s float NOT NULL,
  umidade float NOT NULL,
  nh3 float NOT NULL,
  temperatura float NOT NULL,
  PRIMARY KEY (id),
  KEY odor_data_id_sensor (data, id_sensor),
  KEY odor_id_sensor (id_sensor)
);

-- Query para monitorar em tempo real
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 1 order by id desc limit 1)
union all
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 2 order by id desc limit 1)
union all
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 3 order by id desc limit 1)
union all
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 4 order by id desc limit 1)
union all
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 5 order by id desc limit 1)
union all
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 6 order by id desc limit 1)
union all
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 7 order by id desc limit 1)
union all
(select id_sensor, ocupado, time_to_sec(timediff(now(), data)) delta_agora from presenca where id_sensor = 8 order by id desc limit 1)
;

select extract(hour from data) hora, max(h2s) h2s, max(umidade) umidade, max(nh3) nh3, max(temperatura) temperatura
from odor
where data between '2025-03-03 00:00:00' and '2025-03-14 23:59:59'
group by hora;

-- Query com a total de presença por dia
select id_sensor, date(data) dia, sum(delta) presenca_total from presenca
where data between '2025-03-10 00:00:00' and '2025-03-14 23:59:59' and ocupado = 0
group by id_sensor, dia
order by id_sensor, dia
;
