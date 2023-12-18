class_name CharacterSmoothRotation
extends Component

const ROTATION_SPEED: float = 10.0;

var rotation_direction: Vector3 = Vector3.ZERO;
var previous_rot_direction: Vector3;


func _ready():
	#EBus.GroundLeftClicked.connect(OnGroundLeftClicked);
	pass

func _physics_process(delta: float):
	if self.main_actor.velocity != Vector3.ZERO:
		rotate(delta);
	
	if rotation_direction == Vector3.ZERO:
		return
	main_actor.look_at(rotation_direction,Vector3.UP, true);
	previous_rot_direction = rotation_direction;
	rotation_direction = Vector3.ZERO
	#rotation_direction = Vector3.ZERO;


func rotate(delta: float) -> void:
	self.main_actor.rotation.y = lerp_angle(self.main_actor.rotation.y, atan2(self.main_actor.velocity.x, self.main_actor.velocity.z), delta * ROTATION_SPEED)

func SetRotationDirection(position: Vector3) -> void:
	rotation_direction = position;
	
	
#func OnGroundLeftClicked(position: Vector3) -> void:
	#SetRotationDirection(position);
