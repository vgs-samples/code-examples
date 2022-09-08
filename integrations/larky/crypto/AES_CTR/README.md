# AES CTR sample of encryption in Larky

This sample includes:
1. Python script that generates an ectrypted message of an input data;
2. Larky test `.star` file that generates the same result of the same input data;
3. Ready-for-use YAML (Inbound Route) that produces the same result as previous scripts.

## Testing part:



#### 1. Python:

Python script includes all hard-coded inside. As a result, it prints the encrypted message:
```
$ python python_sample.py
JmVuY3J5cHRlZERhdGE9UnMxSHg0NGZROWVFUXpKaVRGSHBSWU93a0NIS0lpZmxLVFhlLXAtWmlBMDhDa3VHWF96c2x3TzROa2Nfd0dZVzlBcVVTenEzT1NyN2RLOEo1c05WU20zQ0xtckU0ejFhNnRCYnE2TjN5dmdnVXhLb1JTVWp4Nnp4Z1dYTm1BZDdrZjVyYlhydlhnR2UwZVZjdlBFQUE3ZkVmbUJYZDdMM2pWT1JKekJIMGdMWDE0Ry1vQ2pFQVg0VmcxQ2xUbnQwZmVva255VXphczVUcHJld1dGOUJoQ1kzN3VYTVM2U2pNalJiRmc9PSZpdj1zZUJoZU5OWXpFVVJ1eVFS
```

#### 2. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1367" alt="image" src="https://user-images.githubusercontent.com/78090218/189143875-26ce863c-d636-4143-9698-8fc086811b6e.png">

#### 3. YAML file:

Upload the YAML to your vault and run:
```
curl https://tntbmt67sc7.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "query": "MID=4111111111111111&exp_year=2030&exp_month=09&cvv=123&name=CoreyTaylor&amount=100",
    "python": "JmVuY3J5cHRlZERhdGE9UnMxSHg0NGZROWVFUXpKaVRGSHBSWU93a0NIS0lpZmxLVFhlLXAtWmlBMDhDa3VHWF96c2x3TzROa2Nfd0dZVzlBcVVTenEzT1NyN2RLOEo1c05WU20zQ0xtckU0ejFhNnRCYnE2TjN5dmdnVXhLb1JTVWp4Nnp4Z1dYTm1BZDdrZjVyYlhydlhnR2UwZVZjdlBFQUE3ZkVmbUJYZDdMM2pWT1JKekJIMGdMWDE0Ry1vQ2pFQVg0VmcxQ2xUbnQwZmVva255VXphczVUcHJld1dGOUJoQ1kzN3VYTVM2U2pNalJiRmc9PSZpdj1zZUJoZU5OWXpFVVJ1eVFS"
    }'
```

Example of response:
```
"json": {
    "larky_": "JmVuY3J5cHRlZERhdGE9UnMxSHg0NGZROWVFUXpKaVRGSHBSWU93a0NIS0lpZmxLVFhlLXAtWmlBMDhDa3VHWF96c2x3TzROa2Nfd0dZVzlBcVVTenEzT1NyN2RLOEo1c05WU20zQ0xtckU0ejFhNnRCYnE2TjN5dmdnVXhLb1JTVWp4Nnp4Z1dYTm1BZDdrZjVyYlhydlhnR2UwZVZjdlBFQUE3ZkVmbUJYZDdMM2pWT1JKekJIMGdMWDE0Ry1vQ2pFQVg0VmcxQ2xUbnQwZmVva255VXphczVUcHJld1dGOUJoQ1kzN3VYTVM2U2pNalJiRmc9PSZpdj1zZUJoZU5OWXpFVVJ1eVFS",
    "python": "JmVuY3J5cHRlZERhdGE9UnMxSHg0NGZROWVFUXpKaVRGSHBSWU93a0NIS0lpZmxLVFhlLXAtWmlBMDhDa3VHWF96c2x3TzROa2Nfd0dZVzlBcVVTenEzT1NyN2RLOEo1c05WU20zQ0xtckU0ejFhNnRCYnE2TjN5dmdnVXhLb1JTVWp4Nnp4Z1dYTm1BZDdrZjVyYlhydlhnR2UwZVZjdlBFQUE3ZkVmbUJYZDdMM2pWT1JKekJIMGdMWDE0Ry1vQ2pFQVg0VmcxQ2xUbnQwZmVva255VXphczVUcHJld1dGOUJoQ1kzN3VYTVM2U2pNalJiRmc9PSZpdj1zZUJoZU5OWXpFVVJ1eVFS"
  }
```
