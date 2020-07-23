extends Spatial

export(Array, NodePath) var weapon_slots_path = [];
##temporary shit to equip weapons yknow

signal shoot(laser_data, from, direction);

var weapon_slots : Array = [];

func _ready():
	for i in weapon_slots_path:
		weapon_slots.append(get_node(i));
	
	for i in weapon_slots:
		i.connect("shoot", self, "_on_weapon_slot_shoot");
		
func shoot():
	for i in weapon_slots:
		i.shoot();
		
func equip_weapon(var index : int, var weapon_type : Dictionary):
	weapon_slots[index].equip_weapon(weapon_type);
	
func get_weapon_slots():
	return weapon_slots;
	
func _on_weapon_slot_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction);