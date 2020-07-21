extends Node

signal shoot(projectile_type, from, direction, invulnerables);

onready var loadout : Node = get_parent().spaceship.loadout;
onready var timer : Timer = get_node("attack_delay");
onready var sfx_pew : AudioStreamPlayer = get_node("sfx_pew");

var can_shoot : bool = true;
	
func shoot(aim_direction):
	for weapon_slot in loadout.get_weapon_slots():
		if(weapon_slot.has_weapon()):
			if(weapon_slot.shoot()):
				emit_signal("shoot", weapon_slot.current_laser.projectile_type, weapon_slot, -Vector3(aim_direction.x, 0, aim_direction.z), [Groups.Player]);
	
#	if(!can_shoot):
#		return;
#
#	can_shoot = false;
#	timer.start();
#
#	for weapon_slot in loadout.get_weapon_slots():
#		if(weapon_slot.has_weapon()):
#			sfx_pew.play();
#			emit_signal("shoot", Projectile.Type.LASERBEAM_03, weapon_slot, -Vector3(aim_direction.x, 0, aim_direction.z), [Groups.Player]);

func _on_attack_delay_timeout():
	can_shoot = true;
