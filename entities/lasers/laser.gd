extends Spatial

var is_firing : bool;
var fire_direction : Vector3;
var speed : float;
var invulnerables;

func _ready():
	pass

func _process(delta):
	if(is_firing):
		self.global_transform.origin += speed * fire_direction;
		pass
	pass

func fire(var direction : Vector3, var speed : float, var invulnerables : Array):
	self.is_firing = true;
	self.fire_direction = direction;
	self.speed = speed;
	self.invulnerables = invulnerables;
	
	var nd : Vector3 = self.global_transform.origin - fire_direction;
	look_at(Vector3(nd.x, 0, nd.z), Vector3.UP);
	pass

func _on_laser_00_body_entered(body):
	if(invulnerables == null):
		return
		
	for i in invulnerables:
		if(body.is_in_group(i)):
			return
	queue_free();
	pass
