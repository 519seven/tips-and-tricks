Graph QL Cheat Sheet

Query via cURL
-

    curl -X POST -H 'Content-Type: application/json' --data '{"query": "{User {id, name, avgStars, reviews {business {name}, stars}}}"}' http://localhost:4001/graphql

Query via Python
-

    import requests
    r = requests.post('http://localhost:4001/graphql', json={'query': '{User {id, name, avgStars}, reviews {business {name}, stars}}}'}
    print(r.text)
