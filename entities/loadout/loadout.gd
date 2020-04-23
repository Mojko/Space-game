extends Spatial

export(NodePath) var host_path;
export(Array, NodePath) var weapon_slots_path = [];
export(NodePath) var attack_delay_path;

onready var host = get_node(host_path);
onready var attack_delay : Timer = get_node(attack_delay_path);

var laser_model = preload("res://entities/lasers/laser_00/laser_00.tscn");

var weapon_slots : Array = [];
var can_shoot : bool;

func _ready():
	self.can_shoot = true;
	for i in weapon_slots_path:
		var node = get_node(i);
		#node.equip_weapon(Weapons.get_weapon(0));
		weapon_slots.append(node);
		pass
	
	weapon_slots.front().equip_weapon(Weapons.get_weapon(Weapons.Types.LF0));
	
	pass

#func _process(delta):
#	pass

func _on_host_shoot(direction, invulnerables):
	if(can_shoot == false):
		return;
		
	for i in weapon_slots:
		if(!i.has_weapon()):
			continue;
		
		var instance = laser_model.instance();
		get_tree().get_root().add_child(instance);
		instance.global_transform.origin = i.global_transform.origin;
		instance.fire(direction, 0.6, invulnerables);
		pass
	can_shoot = false;
	
	self.attack_delay.start();
	pass
	
func equip_weapon(var index : int, var weapon_type : Dictionary):
	weapon_slots[index].equip_weapon(weapon_type);
	pass
	
func _on_attack_delay_timeout():
	can_shoot = true;
	pass