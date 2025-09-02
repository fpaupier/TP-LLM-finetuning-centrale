docker run --runtime nvidia --gpus all \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    -p 8000:8000 \
    --ipc=host \
    vllm/vllm-openai:latest \
    --api-key ecn-llm-token-update-this-secret \
    --max-model-len 12000 \
    --model Qwen/Qwen3-4B-Instruct-2507
