# TP LLM finetuning Centrale

![Python3.13](https://img.shields.io/badge/python-3.13-blue)

**Cours INFOIA - Informatique durable | Durée : 2h**

## Objectifs

### Objectifs pédagogiques

- Comprendre la génération de datasets d'instruction synthétiques
- Découvrir les techniques de fine-tuning PeFT avec l'exemple LoRA
- Apprendre à utiliser les bibliothèques usuels de training / inférence (vLLM, unsloth, Hugging Face Hub)
- Développer les bonnes pratiques de documentation (model cards)

### Organisation

Ce TP est composé de 2 parties

- la Partie 1 - constitution d'un dataset synthétique
    - _C.f._ [01_synthetic_dataset_generation.ipynb](notebooks/01_synthetic_dataset_generation.ipynb)
- la Partie 2 - fine-tuning avec LoRA
    - _C.f._ [02_lora_finetuning](notebooks/02_lora_finetuning.ipynb)

> [!NOTE]  
> Si vous avez déjà un dataset d'intérêt pour votre sujet, vous pouvez commencer directement dans le
> notebook [02_lora_finetuning](notebooks/02_lora_finetuning.ipynb).
> Vous pourrez alors prendre plus de temps pour ajuster les différents paramètres d'entrainements.

## Getting started

Ce repo utilise `uv` en gestionnaire de paquets.
Voir [astral doc](https://docs.astral.sh/uv/getting-started/installation/) pour l'installation.

### 1. Configuration initiale

```bash
# Cloner le projet
git clone git@github.com:fpaupier/TP-LLM-finetuning-centrale.git
cd TP-LLM-finetuning-centrale

# Créer votre branche
git checkout -b "votre-nom-de-branche"

# Vérifier la disponibilité hardware
nvidia-smi  # Vous devez voir votre GPU 

# Installer uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Installer les dépendances
uv sync
```

#### Configuration de votre serveur d'inférence

Pour générer des données synthétiques, vous aurez besoin d'un serveur d'inférence pouvoir réaliser un dataset synthétique, nous allons utiliser vLLM. Pour cela lancer dans un terminal sur la machine GPU 
```shell
make vllm
```
Le setup initial peut prendre jusqu'à 5mins.

Vous verrez ensuite les logs suivants une fois votre service lancé :

```log
(APIServer pid=1) INFO 09-02 04:14:57 [api_server.py:1880] Starting vLLM API server 0 on http://0.0.0.0:8000
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:36] Available routes are:
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /openapi.json, Methods: GET, HEAD
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /docs, Methods: GET, HEAD
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /docs/oauth2-redirect, Methods: GET, HEAD
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /redoc, Methods: GET, HEAD
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /health, Methods: GET
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /load, Methods: GET
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /ping, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /ping, Methods: GET
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /tokenize, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /detokenize, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/models, Methods: GET
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /version, Methods: GET
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/responses, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/responses/{response_id}, Methods: GET
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/responses/{response_id}/cancel, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/chat/completions, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/completions, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/embeddings, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /pooling, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /classify, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /score, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/score, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/audio/transcriptions, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/audio/translations, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /rerank, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v1/rerank, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /v2/rerank, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /scale_elastic_ep, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /is_scaling_elastic_ep, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /invocations, Methods: POST
(APIServer pid=1) INFO 09-02 04:14:57 [launcher.py:44] Route: /metrics, Methods: GET
(APIServer pid=1) INFO:     Started server process [1]
(APIServer pid=1) INFO:     Waiting for application startup.
(APIServer pid=1) INFO:     Application startup complete.
```

Vous pouvez le tester en lançant une requête de test comme proposé dans 
```shell
make test-vllm
```

## Ressources utiles

### Ressources supplémentaires :

- 📖 [Documentation Unsloth](https://github.com/unslothai/unsloth)
- 📖 [Generate synthetic data for evaluating RAG systems](https://aws.amazon.com/blogs/machine-learning/generate-synthetic-data-for-evaluating-rag-systems-using-amazon-bedrock/)
- 📖 [Guide LoRA/QLoRA](https://huggingface.co/blog/peft)
- 📖 [Best Practices Model Cards](https://huggingface.co/docs/hub/model-cards)
- 📖 [vLLM Documentation](https://docs.vllm.ai/en/stable/)
- 📖 [LLM Course de Maxime Labonne](https://github.com/mlabonne/llm-course)

### Défis bonus (optionnels) :

- Tester d'autres templates d'instruction
- Comparer différents rangs LoRA (8, 16, 32)
- Évaluer quantitativement avec des benchmarks
- Essayer le multi-GPU avec tensor parallelism pour accélérer l'entraînement

---

## Support

### Ressources de debug :

- **Logs vLLM** : consultez la console où vous avez lancé le serveur
- **Logs Jupyter**
- **Monitoring GPU** : `watch -n1 nvidia-smi` dans un terminal


## Commandes utiles

```shell
# To set a password to protect your instance
jupyter notebook password

# To expose your notebook - make sure to update with your host IP
jupyter notebook --no-browser --ip=51.159.189.97 --port=8888 --allow-root
```


For tracking see reference on trackio [here](https://github.com/gradio-app/trackio)

You might want to set up port forwarding between your VM and your local machine to access the dashboard

In your dev machine ssh config (see `~/.ssh/config`): 

```config
Host ecn
    HostName 51.159.189.97
    User root
    Port 22
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
    LocalForward 7861 127.0.0.1:7861  # Forward port for trackio 
```

Then in your VM run `trackio show` and go to `http://localhost:7861` on your browser
