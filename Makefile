.PHONY: vllm vllm-up up vllm-down down

# Start vLLM
vllm:
	./scripts/start_vllm.sh

up: vllm
vllm-up: vllm

# Stop vLLM
vllm-down:
	@docker ps -q --filter ancestor=vllm/vllm-openai | xargs -r docker kill

down: vllm-down