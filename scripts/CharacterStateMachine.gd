class_name CharacterStateMachine
extends Component

@export var character_movement: Node;
#@export var character_movement_input: CharacterMovementInput;
@export var anim_player: AnimationPlayer;
#@export var character_stats: CharacterStats;
var current_anim_speed: float = 0.8;

const BASE_ANIM_BLEND: float = 0.15;

enum BaseState {IDLE, WALK, ATTACK, DIE}
var current_state = BaseState.IDLE;
var isDead:bool = false;

var animations: Dictionary = {"Idle": []
							,"Walk": []
							,"Attack": []
							,"Die": []};

var current_atk_anim: String;


func _ready():
	
	##TODO make this get the value by the character stats
	#current_anim_speed = (character_stats.movement_speed / character_stats.BASE_MOV_SPEED) * character_stats.BASE_ANIM_SPEED;
	
	for anim in anim_player.get_animation_list():
		if anim.contains("Idle"):
			animations["Idle"].append(anim);
		if anim.contains("Walk"):
			animations["Walk"].append(anim);
		if anim.contains("Attack"):
			animations["Attack"].append(anim);
		if anim.contains("Die"):
			animations["Die"].append(anim);
	
	
func _physics_process(delta):
	if isDead:
		return
	
	match current_state:
		BaseState.IDLE:
			idle_state(delta);
			current_state = check_idle_state();
		BaseState.WALK:
			walk_state(delta);
			current_state = check_walk_state();
		BaseState.ATTACK:
			attack_state();
			current_state = check_attack_state();
		BaseState.DIE:
			die_state();
			current_state = check_die_state();
			
func idle_state(delta):
	anim_player.play("Idle_Safe",BASE_ANIM_BLEND, current_anim_speed);
	if self.main_actor.get_parent().name.left(5) == "Other":
		return;
	character_movement.Move(delta);
#	print(self.main_actor.velocity.normalized().length())
	
func check_idle_state():
	var newState = current_state;
	if self.main_actor.velocity.normalized().length() > 0.1:
		newState = BaseState.WALK;
	#if character_stats.current_life <= 0:
		#newState = BaseState.DIE;
	return newState

func walk_state(delta):
	anim_player.play("Walk_Safe", BASE_ANIM_BLEND, current_anim_speed);
	if self.main_actor.get_parent().name.left(5) == "Other":
		return;
	character_movement.Move(delta);
	
func check_walk_state():
	var newState = current_state;
	if self.main_actor.velocity.normalized().length() < 0.1:
		newState = BaseState.IDLE;
	#if character_stats.current_life <= 0:
		#newState = BaseState.DIE;
	return newState

func attack_state():
	anim_player.play(current_atk_anim, BASE_ANIM_BLEND, current_anim_speed);
	#await anim_player.animation_finished;
	
	#if anim_player.get_current_animation_position() >= 0.6:
	#	current_state = BaseState.IDLE;
	#if character_movement_input:
	#	character_movement_input.canMove = false;
	#anim_player.play("Attack_Unarm_01-01", BASE_ANIM_BLEND, current_anim_speed * character_stats.AttackSpeed);
	#if anim_player.get_current_animation_position() >= BASE_ANIM_BLEND and anim_player.get_current_animation_position() <= 0.33:
	#	var hitBoxCol = atkHandler.hitBox.get_node("HitBoxColShape");
	#	hitBoxCol.disabled = false;
	#else:
	#	var hitBoxCol = atkHandler.hitBox.get_node("HitBoxColShape");
	#	hitBoxCol.disabled = true;
	pass
	
func check_attack_state():
	var newState = current_state;
#
	if anim_player.get_current_animation_position() >= 0.6:
	#	atkHandler.target = null
	#	if character_movement_input:
	#		character_movement_input.canMove = true;
		newState = BaseState.IDLE;
	#if character_stats.current_life <= 0:
	#	newState = BaseState.DIE;
	return newState
	
	
func die_state():
	Die();


func check_die_state():
	var newState = current_state;
	return newState

func Die():
	var colShapes = self.main_actor.find_children("*", "CollisionShape3D");
	for col in colShapes:
		col.disabled = true;
	anim_player.play("Die",BASE_ANIM_BLEND, current_anim_speed);
	
	isDead = true
	

func SetAttackState(atkAnim: String):
	current_atk_anim = atkAnim;
	current_state = BaseState.ATTACK;
