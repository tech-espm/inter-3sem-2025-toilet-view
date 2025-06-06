# Projeto Interdisciplinar III - Sistemas de Informação ESPM

<p align="center">
    <a href="https://www.espm.br/cursos-de-graduacao/sistemas-de-informacao/"><img src="https://raw.githubusercontent.com/tech-espm/misc-template/main/logo.png" alt="Sistemas de Informação ESPM" style="width: 375px;"/></a>
</p>

# Toilet View - Sistema de Monitoramento de Ocupação de Banheiro

### 2025-01

## Integrantes
- [José Longo Neto](https://github.com/Jose-Longo-A)
- [Pedro Maricate](https://github.com/PedroMaricate)
- [Martim Ponzio](https://github.com/martimponzio)
- [Pablo Dimitrof](https://github.com/PabloDimitrof)
- [Enzo Malagoli](https://github.com/EnzoMalagoli)
- [Eduardo Gul](https://github.com/eduardogd09)

## Descrição do Projeto

O projeto propõe um sistema inteligente de monitoramento de banheiros, capaz de indicar em tempo real a disponibilidade das cabines e a necessidade de limpeza com base na detecção de odores e ocupação. Dessa forma, os usuários podem visualizar rapidamente a ocupação das cabines antes de entrar no banheiro, otimizando o tempo de espera e evitando deslocamentos desnecessários. Além disso, o monitoramento da qualidade do ar permite uma melhor gestão da limpeza, garantindo um ambiente mais confortável e higiênico.

## Configuração do Projeto

Para executar, deve criar o arquivo `config.py` da seguinte forma:

```python
host = '0.0.0.0'
port = 3000
conexao_banco = 'mysql+mysqlconnector://usuario:senha@host/banco'
url_api = 'https://site.com'
```

Todos os comandos abaixo assumem que o terminal esteja com o diretório atual na raiz do projeto.

## Criação e Ativação do venv

```
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
```

## Execução

```
.venv\Scripts\activate
python app.py
```

## Mais Informações

https://flask.palletsprojects.com/en/3.0.x/quickstart/
https://flask.palletsprojects.com/en/3.0.x/tutorial/templates/

# Licença

Este projeto é licenciado sob a [MIT License](https://github.com/tech-espm/inter-3sem-2025-toilet-view/blob/main/LICENSE).

<p align="right">
    <a href="https://www.espm.br/cursos-de-graduacao/sistemas-de-informacao/"><img src="https://raw.githubusercontent.com/tech-espm/misc-template/main/logo-si-512.png" alt="Sistemas de Informação ESPM" style="width: 375px;"/></a>
</p>
