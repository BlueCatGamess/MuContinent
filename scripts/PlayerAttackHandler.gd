class_name PlayerAttackHandler
extends Component

@export var character_state_machine: CharacterStateMachine;
@export var character_smooth_rotation: CharacterSmoothRotation;

var available_attacks: Dictionary = {
	"BasicAttack" : "Attack_Unarm_01-01"
	,"Attack01"   : "Attack_Spell_Projectile"
	,"Attack02"   : "Attack_DHspear_03-01"
	,"Attack03"   : "Attack_Bow_01-01"
	,"Attack04"   : "Attack_Dwield_01-01" } ##TODO use the attack name to know the attack anim

func ProcessAttack(target_info: Dictionary, attack_input: String) -> void:
	if CheckAttack() == false:
		return;
	if target_info.is_empty():
		return;
	if attack_input == "BasicAttack":
		character_state_machine.MatchAttackAnim();
	else:
		character_state_machine.current_atk_anim = available_attacks[attack_input];
		
	self.main_actor.velocity = Vector3.ZERO;
	character_state_machine.current_state = character_state_machine.BaseState.ATTACK;
	var target_pos: Vector3 = Vector3(target_info.position.x, 0.0,target_info.position.z)
	character_smooth_rotation.SetRotationDirection(target_pos);

func CheckAttack() -> bool:
	if character_state_machine.current_state == character_state_machine.BaseState.ATTACK:
		return false
	else:
		return true
