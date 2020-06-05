extends Spatial

export(PackedScene) var hit_particle;

signal hit();
signal death(instance);

onready var death_timer = get_node("death_timer");

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

func fire(var direction : Vector3, var speed : float, var invulnerables : Array):
	self.is_firing = true;
	self.fire_direction = direction;
	self.speed = speed;
	self.invulnerables = invulnerables;
	death_timer.start();
	
	var nd : Vector3 = self.global_transform.origin - fire_direction;
	look_at(Vector3(nd.x, 0, nd.z), Vector3.UP);
	pass

func _on_laser_00_body_entered(body):
	if(invulnerables == null):
		return
		
	for i in invulnerables:
		if(body.is_in_group(i)):
			return
			
	if(body.has_method("on_hit")):
		body.on_hit();
			
	emit_signal("death", self);
	death_timer.stop();
			
#	var instance = self.hit_particle.instance();
#	instance.set_emitting(true);
#	get_tree().get_root().add_child(instance);
#	instance.global_transform.origin = Vector3(self.global_transform.origin.x, self.global_transform.origin.y, self.global_transform.origin.z);
#
#	if(body.has_method("on_hit")):
#		body.on_hit();
#
#	queue_free();
	pass

func _on_death_timer_timeout():
	emit_signal("death", self);
	death_timer.stop();
