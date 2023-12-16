class_name GroundRayDetector
extends Component

const RAY_LENGTH: int = 1000;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("LeftClick"):
		var space_state: PhysicsDirectSpaceState3D = main_actor.get_world_3d().direct_space_state;
		var cam: Camera3D = main_actor;
		var mousepos: Vector2 = get_viewport().get_mouse_position();

		var origin: Vector3 = cam.project_ray_origin(mousepos);
		var end: Vector3 = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH;
		var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin, end);
		query.collision_mask = pow(2, 10-1);
		
		var result: Dictionary = space_state.intersect_ray(query);
		EBus.GroundLeftClicked.emit(result.position); #TODO Create the event receiver
