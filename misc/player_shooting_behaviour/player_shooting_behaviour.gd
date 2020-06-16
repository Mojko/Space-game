extends Node

signal shoot(from, direction, invulnerables);

onready var loadout : Node = get_parent();
onready var timer : Timer = get_node("attack_delay");

var can_shoot : bool = true;
	
func shoot(aim_direction):
	if(!can_shoot):
		return;
	
	can_shoot = false;
	timer.start();
	
	for weapon_slot in loadout.get_weapon_slots():
		if(weapon_slot.has_weapon()):
			emit_signal("shoot", weapon_slot, -Vector3(aim_direction.x, 0, aim_direction.z), [Groups.Player]);

func _on_attack_delay_timeout():
	can_shoot = true;
