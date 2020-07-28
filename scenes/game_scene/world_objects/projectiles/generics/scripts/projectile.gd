extends Area
class_name ProjectileEntity

export(String, "on_hit", "on_hit_electricity") var method_to_call;

signal hit();
signal death(instance);

onready var death_timer = get_node("death_timer");
onready var sfx_shoot = get_node("sfx_shoot");

var source : Spatial;
var is_firing : bool;
var fire_direction : Vector3;
var invulnerables;
var laser_data;

func _ready():
	assert(death_timer);
	assert(sfx_shoot);
	connect("body_entered", self, "on_body_entered");

func fire(laser_data : Laser, from : Spatial, direction : Vector3, invulnerables : Array):
	self.source = from;
	self.is_firing = true;
	self.fire_direction = direction;
	self.invulnerables = invulnerables;
	self.laser_data = laser_data;
	death_timer.start();
	sfx_shoot.play();

func on_body_entered(body):
	if(!is_firing):
		return
		
	for i in invulnerables:
		if(body.is_in_group(i)):
			return
			
	if(body.has_method(method_to_call)):
		body.call(method_to_call, source, laser_data.damage);
		
	return true;
	
func die():
	emit_signal("death", self);
	death_timer.stop();
	reset();

func _on_death_timer_timeout():
	die();
	
func reset():
	self.source = null;
	self.is_firing = false;
	self.fire_direction = Vector3();
	self.invulnerables = null;
