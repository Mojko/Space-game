extends Spatial

export(PackedScene) var hit_particle;

signal hit();
signal death(instance);

onready var death_timer = get_node("death_timer");

var source : Spatial;
var is_firing : bool;
var fire_direction : Vector3;
var speed : float;
var invulnerables;

func _ready():
	pass

func _process(delta):
	if(is_firing):
		self.global_transform.origin += speed * fire_direction * (delta * 50);
		pass
	pass

func fire(from : Spatial, direction : Vector3, speed : float, invulnerables : Array):
	self.source = from;
	self.is_firing = true;
	self.fire_direction = direction;
	self.speed = speed;
	self.invulnerables = invulnerables;
	death_timer.start();
	
	var nd : Vector3 = self.global_transform.origin - fire_direction;
	look_at(Vector3(nd.x, 0, nd.z), Vector3.UP);
	self.rotation.x = 0;
	self.rotation.z = 0;
	pass

func _on_laser_00_body_entered(body):
	if(invulnerables == null):
		return
		
	for i in invulnerables:
		if(body.is_in_group(i)):
			return
			
	if(body.has_method("on_hit")):
		body.on_hit(source);
		
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
	self.speed = 0;
	self.invulnerables = null;
