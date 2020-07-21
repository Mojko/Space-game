extends Spatial

export(Array, NodePath) var weapon_slots_path = [];
##temporary shit to equip weapons yknow
export(Resource) var wew;

signal shoot(from, direction, invulnerables);

var weapon_slots : Array = [];

func _ready():
	for i in weapon_slots_path:
		weapon_slots.append(get_node(i));
		
	for i in weapon_slots:
		i.equip_weapon(wew);
		
func equip_weapon(var index : int, var weapon_type : Dictionary):
	weapon_slots[index].equip_weapon(weapon_type);
	
func get_weapon_slots():
	return weapon_slots;