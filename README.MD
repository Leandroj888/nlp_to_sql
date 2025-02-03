# Subir o Sistema
## opensearch
senha **laboR4toRio**

### Iniciar
subir o sistema **docker-compose up** se quiser iniciar em background adicione *-d* no comando

derrubar o sistema **docker-compose down**

### Acessos
acessar o docker **sudo exec -it opensearch bash**

acessar bash **docker exec -it opensearch bash**

log **docker logs -f opensearch**

testar **curl -u admin:laboR4toRio -k https://localhost:9200**

### Manipular Index

listar index **curl -X GET http://localhost:9200/_cat/indices?v**

deletar index **curl -X DELETE "http://localhost:9200/seu_indice"**

deletar documento **curl -X DELETE "http://localhost:9200/seu_indice/_doc/seu_id"**

Deletar todos os documentos de um índice (mas manter o índice) 
```
curl -X POST "http://localhost:9200/seu_indice/_delete_by_query" -H "Content-Type: application/json" -d '{
  "query": {
    "match_all": {}
  }
}'
```

buscar um índice (mas manter o índice) 
```
curl -X POST "http://localhost:9200/seu_indice/_delete_by_query" -H "Content-Type: application/json" -d '{
  "query": {
    "match_all": {}
  }
}'
```

## llm


## python

### Rodar projeto local
1. Instale o python na maquina local
```
sudo apt install -y python3.10
sudo apt install -y python3.10-venv
sudo apt install -y python3-pip
```

2. Crie o ambiente virtual
```
python3 -m venv venv
```

3. Ative o ambiente virtual
```
source venv/bin/activate 
```

* Caso precise sair do ambiente virtual
```
deactivate
```

4. Instale os requisitos
```
pip install -r requirements.txt
```

python3 main.py

python3 -m debugpy --listen 0.0.0.0:5678 main.py


curl -X POST http://localhost:5000/create_index

curl -X POST http://localhost:5000/search -H "Content-Type: application/json" -d '{"query": "1989"}'
