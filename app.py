from flask import Flask, render_template, json, request, Response
import config
import requests
import banco
from datetime import datetime

app = Flask(__name__)

@app.get('/')
def index():
    hoje = datetime.today().strftime('%Y-%m-%d')
    return render_template('index/index.html', hoje=hoje)

@app.get('/monitorar')
def monitorar():
    return render_template('index/monitorar.html', titulo='Monitorar Presenças')

@app.get('/sobre')
def sobre():
    return render_template('index/sobre.html', titulo='Sobre Nós')

@app.get('/login')
def login():
    return render_template('index/login.html', titulo='Login')

@app.get('/cadastro')
def cadastro():
    return render_template('index/cadastro.html', titulo='Cadastro')

@app.get('/dashboard')
def dashboard():
    return render_template('index/dashboard.html', titulo='Dashboard')

@app.get('/obterDados')
def obterDados():
    # Obter o maior id do banco
    maior_id = banco.obterIdMaximo("presenca")

    resultado = requests.get(f'{config.url_api}?sensor=presence&id_inferior={maior_id}')
    dados_novos = resultado.json()

	# Inserir os dados novos no banco
    if dados_novos and len(dados_novos) > 0:
        banco.inserirPresencas(dados_novos)

    dados = banco.monitorarPresencasTempoReal()

    return json.jsonify(dados)

@app.get('/monitorarTempoReal')
def monitorarTempoReal():
    # Obter o maior id do banco
    maior_id = banco.obterIdMaximo("presenca")

    resultado = requests.get(f'{config.url_api}?sensor=presence&id_inferior={maior_id}')
    dados_novos = resultado.json()

	# Inserir os dados novos no banco
    if dados_novos and len(dados_novos) > 0:
        banco.inserirPresencas(dados_novos)

    maior_id = banco.obterIdMaximo("odor")

    resultado = requests.get(f'{config.url_api}?sensor=odor&id_inferior={maior_id}')
    dados_novos = resultado.json()

	# Inserir os dados novos no banco
    if dados_novos and len(dados_novos) > 0:
        banco.inserirOdor(dados_novos)

    presencas = banco.monitorarPresencasTempoReal()
    odor = banco.monitorarOdorTempoReal(datetime.today().strftime('%Y-%m-%d'))
    usos_hoje = banco.usosHoje()

    return json.jsonify({
        'presencas': presencas,
        'odor': odor,
        'usosHoje': usos_hoje
	})

@app.post('/criar')
def criar():
    dados = request.json
    print(dados['id'])
    print(dados['nome'])
    return Response(status=204)

if __name__ == '__main__':
    app.run(host=config.host, port=config.port)
