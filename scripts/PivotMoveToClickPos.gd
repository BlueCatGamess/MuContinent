class_name PivotMoveToClickPos
extends Component


# Called when the node enters the scene tree for the first time.
func _ready():
	EBus.GroundLeftClicked.connect(OnGroundLeftClicked);


func OnGroundLeftClicked(position: Vector3) -> void:
	main_actor.global_position = position;
	var anim: AnimationPlayer = main_actor.get_node("AnimationPlayer");
	anim.seek(0.1);
	anim.play("MovePivot");
