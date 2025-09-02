docker run --runtime nvidia --gpus all \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    -p 8000:8000 \
    --ipc=host \
    vllm/vllm-openai:latest \
    --api-key ecn-llm-token-update-this-secret \
    --model Qwen/Qwen3-8B
