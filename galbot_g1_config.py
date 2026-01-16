"""
Modality configuration for Galbot G1.
"""

from gr00t.configs.data.embodiment_configs import register_modality_config
from gr00t.data.embodiment_tags import EmbodimentTag
from gr00t.data.types import (
    ActionConfig,
    ActionFormat,
    ActionRepresentation,
    ActionType,
    ModalityConfig,
)


galbot_g1_config = {
    # Video modality: 4 cameras
    "video": ModalityConfig(
        delta_indices=[0],  # Current frame only
        modality_keys=[
            "head_left_camera_color_optical_frame",
            "head_right_camera_color_optical_frame",
            "left_arm_camera_color_optical_frame",
            "right_arm_camera_color_optical_frame",
        ],
    ),
    
    # State modality: proprioceptive observations
    "state": ModalityConfig(
        delta_indices=[0],  # Current state
        modality_keys=[
            "left_arm_joint",
            "left_gripper_joint",
            "right_arm_joint",
            "right_gripper_joint",
        ],
        sin_cos_embedding_keys=["left_arm_joint", "right_arm_joint"],
    ),
    
    # Action modality: 16-step prediction horizon
    "action": ModalityConfig(
        delta_indices=list(range(0, 16)),  # Predict 16 steps into the future
        modality_keys=[
            "left_arm_joint",
            "left_gripper_joint",
            "right_arm_joint",
            "right_gripper_joint",
        ],
        action_configs=[
            # left_arm: use absolute actions (matching old config with min_max normalization)
            ActionConfig(
                rep=ActionRepresentation.ABSOLUTE,
                type=ActionType.NON_EEF,  # Joint space control
                format=ActionFormat.DEFAULT,
            ),
            # left_gripper: use absolute actions
            ActionConfig(
                rep=ActionRepresentation.ABSOLUTE,
                type=ActionType.NON_EEF,
                format=ActionFormat.DEFAULT,
            ),
            # right_arm: use absolute actions
            ActionConfig(
                rep=ActionRepresentation.ABSOLUTE,
                type=ActionType.NON_EEF,
                format=ActionFormat.DEFAULT,
            ),
            # right_gripper: use absolute actions
            ActionConfig(
                rep=ActionRepresentation.ABSOLUTE,
                type=ActionType.NON_EEF,
                format=ActionFormat.DEFAULT,
            ),
        ],
    ),
    
    # Language modality: task description
    "language": ModalityConfig(
        delta_indices=[0],
        modality_keys=["annotation.human.task_description"],
    ),
}

# Register the configuration
register_modality_config(galbot_g1_config, embodiment_tag=EmbodimentTag.NEW_EMBODIMENT)