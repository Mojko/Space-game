extends Spatial

export(Array, NodePath) var weapon_slots_path = [];
export(NodePath) var attack_delay_path;

signal has_shot;

onready var attack_delay : Timer = get_node(attack_delay_path);

var laser_model = preload("res://entities/lasers/laser_00/laser_00.tscn");

var weapon_slots : Array = [];
var can_shoot : bool;

func _ready():
	self.can_shoot = true;
	for i in weapon_slots_path:
		var node = get_node(i);
		weapon_slots.append(node);
		pass
	
	weapon_slots.front().equip_weapon(Weapons.get_weapon(Weapons.Types.LF0));
	pass

func equip_weapon(var index : int, var weapon_type : Dictionary):
	weapon_slots[index].equip_weapon(weapon_type);
	pass
	
func get_loadout():
	return weapon_slots;
	
func _on_attack_delay_timeout():
	can_shoot = true;
	pass