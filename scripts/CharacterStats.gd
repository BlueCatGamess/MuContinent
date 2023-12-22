class_name CharacterStats
extends Component

enum Attributes { STRENGTH, TALENT, AGILITY, VITALITY, INTELLIGENCE}
enum Statistics { LIFE, MANA, DAMAGE, ARMOR, ATKSPEED, MOVESPEED
				, EVASIONCHANCE, CRITICALCHANCE, BLOCKCHANCE}

const BASE_ANIM_SPEED: float = 0.7;
const BASE_MOV_SPEED: float = 3.0;
const BASE_ATK_SPEED: float = 1.0;
const BASE_ROT_SPEED: float = 6.0;

# TODO Get this stats from server
@export_group("Attributes")
@export var strength: float = 0;
@export var talent: float = 0;
@export var agility: float = 0;
@export var vitality: float = 0;
@export var intelligence: float = 0;

@export_group("Statistics")
@export var life: float = 100:
	set(new_value):
		life = new_value;
		#Ebus.statChanged.emit(self.main_actor, "life", life);
var current_life: float = 100:
	set(new_value):
		current_life = new_value;
		#Ebus.statChanged.emit(self.main_actor, "current_life", current_life);

@export var mana: float = 100:
	set(new_value):
		mana = new_value;
		#Ebus.statChanged.emit(self.main_actor, "life", life);
var current_mana: float = 100:
	set(new_value):
		current_mana = new_value;
		#Ebus.statChanged.emit(self.main_actor, "current_life", current_life);

@export var damage: float = 10;

@export var armor: float = 5;
var current_armor: float;

@export var attack_speed: float = 1.0;
var current_attack_speed: float = attack_speed:
	set(new_value):
		current_attack_speed = new_value;
		EBus.statChanged.emit(self.main_actor, "current_attack_speed",current_attack_speed);

@export var movement_speed: float = 3.0;
var current_movement_speed: float = movement_speed:
	set(new_value):
		current_movement_speed = new_value;
		EBus.statChanged.emit(self.main_actor, "current_movement_speed",current_movement_speed);

@export var evasion_chance: float = 5.0;
var current_evasion_chance: float;

@export var critical_chance: float = 5.0;
var current_critical_chance: float;

@export var block_chance: float = 5.0;
var current_block_chance: float;


func _ready():
	if self.main_actor.get_parent().name.left(5) == "Other":
		#SendRequestCharStats(main_actor.name, 2); # 2 other players
		return;
	#Ebus.playerEntered.emit(self.main_actor);
	
## TODO this function will be called by the server to update the client char stats
func UpdateCharStats(statName: String, statValue: float) -> void:
	match statName:
		"strength":
			strength = statValue;
		"talent":
			talent = statValue;
		"agility":
			agility = statValue;
		"vitality":
			vitality = statValue;
		"intelligence":
			intelligence = statValue;
		"life":
			life = statValue;
		"current_life":
			current_life = statValue;
		"damage":
			damage = statValue;
		"armor":
			armor = statValue;
		"current_armor":
			current_armor = statValue;
		"attack_speed":
			attack_speed = statValue;
		"current_attack_speed":
			current_attack_speed = statValue;
		"movement_speed":
			movement_speed = statValue;
		"current_movement_speed":
			current_movement_speed = statValue;

#func SendRequestCharStats(charId: String, charType: int):
	#GameServer.RequestCharStats(charId, charType);
