extends Spatial

export(Array, NodePath) var weapon_slots_path = [];
export(NodePath) var attack_delay_path;
export(NodePath) var shooting_behaviour_path;

signal shoot(from, direction, invulnerables);

onready var attack_delay : Timer = get_node(attack_delay_path);
onready var shooting_behaviour : Node = get_node(shooting_behaviour_path);

var weapon_slots : Array = [];

func _ready():
	for i in weapon_slots_path:
		var node = get_node(i);
		weapon_slots.append(node);
		pass
		
	weapon_slots[0].equip_weapon(Weapons.get_weapon(Weapons.Types.LF0));
	pass

func equip_weapon(var index : int, var weapon_type : Dictionary):
	weapon_slots[index].equip_weapon(weapon_type);
	pass
	
func get_weapon_slots():
	return weapon_slots;