extends Spatial

export(Array, NodePath) var weapon_slots_path = [];
export(NodePath) var shooting_behaviour_path;

signal shoot(from, direction, invulnerables);

onready var shooting_behaviour : Node = get_node(shooting_behaviour_path);

var weapon_slots : Array = [];

func _ready():
	for i in weapon_slots_path:
		var node = get_node(i);
		weapon_slots.append(node);
		pass
		
	for i in weapon_slots:
		i.equip_weapon(Weapons.get_weapon(Weapons.Types.LF0));
		
func equip_weapon(var index : int, var weapon_type : Dictionary):
	weapon_slots[index].equip_weapon(weapon_type);
	
func get_weapon_slots():
	return weapon_slots;