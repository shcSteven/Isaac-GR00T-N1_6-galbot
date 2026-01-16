#!/bin/bash
set -x -e

# Fine-tuning script for Galbot G1

export NUM_GPUS=1

# Path configuration
DATASET_PATH="/home/haochen/Projects_Haochen/galbot_dataset/task1_20260108_no_rnd_trimmed"
MODALITY_CONFIG_PATH="./galbot_g1_config.py"
OUTPUT_DIR="/home/haochen/Projects_Haochen/gr00t_ckpt/n1d6_try"


CUDA_VISIBLE_DEVICES=0 uv run python \
    ./gr00t/experiment/launch_finetune.py \
    --base_model_path nvidia/GR00T-N1.6-3B \
    --dataset_path ${DATASET_PATH} \
    --modality_config_path ${MODALITY_CONFIG_PATH} \
    --embodiment_tag NEW_EMBODIMENT \
    --num_gpus ${NUM_GPUS} \
    --output_dir ${OUTPUT_DIR} \
    --save_steps 1000 \
    --save_total_limit 5 \
    --max_steps 10000 \
    --warmup_ratio 0.05 \
    --weight_decay 1e-5 \
    --learning_rate 1e-4 \
    --use_wandb \
    --global_batch_size 4 \
    --color_jitter_params brightness 0.3 contrast 0.4 saturation 0.5 hue 0.08 \
    --dataloader_num_workers 4