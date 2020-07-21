extends Area

export(String, "on_hit", "on_hit_electricity") var method_to_call;

signal death(who);

var projectile_data : Dictionary;
var has_fired = false;

# Function: fire(projectile_data)
#
# projecitle_data structure:
#
# source - The source of the attacker
# invulnerables - The groups that is invincible to the projectile
#
####
func fire(projectile_data : Dictionary):
	self.projectile_data = projectile_data;
	has_fired = true;
	$death_timer.start();
	$gfx_laser.start();
	look_at(global_transform.origin + projectile_data["direction"], Vector3(0,1,0));

func _on_projectile03_laserbeam_body_entered(body):
	pass
#	if(!has_fired):
#		return;
#
#	for i in projectile_data["invulnerables"]:
#		if(body.is_in_group(i)):
#			return
#
#	if(body.has_method(method_to_call)):
#		body.call(method_to_call, projectile_data["source"]);
#
#	die();
	
func die():
	emit_signal("death", self);
	$death_timer.stop();
	has_fired = false;