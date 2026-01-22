# Fine-tuning script for Galbot G1
set -x -e

export NUM_GPUS=2
TASK_NAME="task3_01210122_merged"

# Path configuration
DATASET_PATH="/localhome/local-haochens/data/galbot_lerobot_dataset/${TASK_NAME}"
MODALITY_CONFIG_PATH="./galbot_g1_config.py"
OUTPUT_DIR="/localhome/local-haochens/ckpt_${TASK_NAME}"


CUDA_VISIBLE_DEVICES=0,1 uv run torchrun --nproc_per_node=${NUM_GPUS} ./gr00t/experiment/launch_finetune.py \
    --base-model-path nvidia/GR00T-N1.6-3B \
    --dataset_path ${DATASET_PATH} \
    --modality_config_path ${MODALITY_CONFIG_PATH} \
    --embodiment_tag NEW_EMBODIMENT \
    --num_gpus ${NUM_GPUS} \
    --output_dir ${OUTPUT_DIR} \
    --save_steps 10000 \
    --save_total_limit 5 \
    --max_steps 100000 \
    --warmup_ratio 0.05 \
    --weight_decay 1e-5 \
    --learning_rate 1e-4 \
    --use_wandb \
    --global_batch_size 32 \
    --color_jitter_params brightness 0.3 contrast 0.4 saturation 0.5 hue 0.08 \
    --dataloader_num_workers 2 \
    --state_dropout_prob 0.1 \
    --tune_visual