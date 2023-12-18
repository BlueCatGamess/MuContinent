class_name PlayerInput
extends Component

const RAY_LENGTH: int = 1000;

@export var character_state_machine: CharacterStateMachine;
@export var character_movement: Node;
@export var player_atk_handler: PlayerAttackHandler;
var cam: Camera3D;

var result_from_ray: Dictionary;

# Called when the node enters the scene tree for the first time.
func _ready():
	cam  = main_actor.get_tree().root.get_node("Main/MainCamera");

func _physics_process(_delta) -> void:
	if Input.is_action_pressed("Move"):
		EBus.PlayerMovePressed.emit();
		CastRayFromCamera(10);
		if not result_from_ray.is_empty():
			character_movement.SetDestination(result_from_ray.position);
			EBus.GroundLeftClicked.emit(result_from_ray.position);
			
	elif Input.is_action_pressed("BasicAttack"):
		Attack("BasicAttack");
	elif Input.is_action_pressed("Attack01"):
		Attack("Attack01");
	elif Input.is_action_pressed("Attack02"):
		Attack("Attack02");
	elif Input.is_action_pressed("Attack03"):
		Attack("Attack03");
	elif Input.is_action_pressed("Attack04"):
		Attack("Attack04");

func _input(event) -> void:
	if event.is_action_pressed("Dodge"):
		print("Dodge")

func CastRayFromCamera(col_mask: int = 0) -> void:
	var space_state: PhysicsDirectSpaceState3D = main_actor.get_world_3d().direct_space_state;
	var mousepos: Vector2 = get_viewport().get_mouse_position();

	var origin: Vector3 = cam.project_ray_origin(mousepos);
	var end: Vector3 = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH;
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin, end);
	if col_mask != 0:
		query.collision_mask = int(pow(2, col_mask-1));
	
	result_from_ray = space_state.intersect_ray(query);

func Attack(attack_input: String, col_mask: int = 0) -> void:
	CastRayFromCamera(col_mask);
	player_atk_handler.ProcessAttack(result_from_ray,attack_input);
