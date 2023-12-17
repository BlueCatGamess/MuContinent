class_name CharacterSmoothRotation
extends Component

const ROTATION_SPEED: float = 10.0;

func _physics_process(delta: float):
	if self.main_actor.velocity == Vector3.ZERO:
		return
	
	rotate(delta);


func rotate(delta: float) -> void:
	self.main_actor.rotation.y = lerp_angle(self.main_actor.rotation.y, atan2(self.main_actor.velocity.x, self.main_actor.velocity.z), delta * ROTATION_SPEED)
