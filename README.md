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
```

## Ressources utiles

### Ressources supplémentaires :

- 📖 [Documentation Unsloth](https://github.com/unslothai/unsloth)
- 📖 [Guide LoRA/QLoRA](https://huggingface.co/blog/peft)
- 📖 [Best Practices Model Cards](https://huggingface.co/docs/hub/model-cards)
- 📖 [vLLM Documentation](https://docs.vllm.ai/en/stable/)

### Défis bonus (optionnels) :

- Tester d'autres templates d'instruction
- Comparer différents rangs LoRA (8, 16, 32)
- Évaluer quantitativement avec des benchmarks
- Essayer le multi-GPU avec tensor parallelism pour accélérer l'entraînement

---

## Support

### Ressources de debug :

- 📋 **Logs vLLM** : consultez la console où vous avez lancé le serveur
- 🔍 **Logs Jupyter**
- 🎮 **Monitoring GPU** : `watch -n1 nvidia-smi` dans un terminal
