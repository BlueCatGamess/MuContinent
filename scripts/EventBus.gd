extends Node

##Signal emitted when a mouse Left click on Ground
signal GroundLeftClicked(position: Vector3);

signal PlayerMovePressed();
signal PlayerDodgePressed(position: Vector3);
signal PlayerBasicAttackPressed(position: Vector3);
signal PlayerAttack01Pressed(position: Vector3);

signal statChanged(character: CharacterBody3D, statName: String, statValue: int);
