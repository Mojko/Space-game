extends Spatial

export(String, "on_hit", "on_hit_electricity") var method_to_call;
export(PackedScene) var hit_particle;

signal hit();
signal death(instance);

onready var death_timer = get_node("death_timer");

var source : Spatial;
var is_firing : bool;
var fire_direction : Vector3;
var invulnerables;
var laser_data;

func _ready():
	pass

func _process(delta):
	if(is_firing):
		self.global_transform.origin += laser_data.speed * fire_direction * (delta * 50);
		pass
	pass

func fire(laser_data : Laser, from : Spatial, direction : Vector3, invulnerables : Array):
	self.source = from;
	self.is_firing = true;
	self.fire_direction = direction;
	self.invulnerables = invulnerables;
	self.laser_data = laser_data;
	death_timer.start();
	if($sfx_shoot != null):
		$sfx_shoot.play();
	
	var nd : Vector3 = self.global_transform.origin - fire_direction;
	look_at(Vector3(nd.x, 0, nd.z), Vector3.UP);
	self.rotation.x = 0;
	self.rotation.z = 0;
	pass

func _on_laser_00_body_entered(body):
	if(!is_firing):
		return
		
	for i in invulnerables:
		if(body.is_in_group(i)):
			return
			
	if(body.has_method(method_to_call)):
		body.call(method_to_call, source);
		
	die();
	
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
