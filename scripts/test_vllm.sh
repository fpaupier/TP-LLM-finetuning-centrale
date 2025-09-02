curl http://172.17.0.1:8021/v1/completions \
-H "Content-Type: application/json" \
-H "Authorization: Bearer ecn-llm-token-update-this-secret" \
-d '{
    "model": "Qwen/Qwen3-4B",
    "prompt": "Quels sont les sujets enseignés à l école Centrale de Nantes",
    "max_tokens": 128,
    "temperature": 0.8
}'