class_name CameraFollow
extends Component


@export var target: CharacterBody3D; 
@export var offset: Vector3 = Vector3.ZERO;
@export var smooth_force: float = 1.0;


func _ready() -> void:
	#FIXME Ebus.playerEntered.connect(OnPlayerEntered);
	pass


func _physics_process(_delta) -> void:
	
	if target == null:
		return
	
	var desired_position: Vector3 = target.global_transform.origin + offset;
	var smoothed_position: Vector3 = self.main_actor.global_transform.origin.lerp(desired_position, smooth_force)
	self.main_actor.global_transform.origin = smoothed_position;

func OnPlayerEntered(player: CharacterBody3D) -> void:
	target = player;
