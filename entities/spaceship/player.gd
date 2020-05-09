extends Entity
class_name Player

export(NodePath) var camera_path;
export(NodePath) var aim_timer_path;
export(NodePath) var sfx_pew_path;

signal thrust(state);
signal shoot(direction, invulnerables);

onready var camera : Camera = get_node(camera_path);
onready var aim_timer : Timer = get_node(aim_timer_path);
onready var sfx_pew : AudioStreamPlayer = get_node(sfx_pew_path);

var spaceship : Spaceship;
var direction : Vector3 = Vector3();
var rotate_with_mouse : bool = false;

func _physics_process(delta):
	
	var velocity = handle_movement();
	emit_fire_particle();
	handle_shooting();
		
	#Look towards where you're going
	if(rotate_with_mouse == false and velocity.length() > 0):
		self.look_at_smooth(-direction, 0.2);
		pass
	pass

#####
# Function: handle_movement()
#
# Returns: velocity of movement
#
####
func handle_movement() -> Vector3:
	direction = Vector3();
	
	if(Input.is_action_pressed("move_up")):
		direction.z += -1;
		direction.x += 2;
		pass
	if(Input.is_action_pressed("move_right")):
		direction.x += 1;
		direction.z += 2;
		pass
	if(Input.is_action_pressed("move_left")):
		direction.x += -1;
		direction.z += -2;
		pass
	if(Input.is_action_pressed("move_down")):
		direction.z += 1;
		direction.x += -2;
		pass
		
	var velocity = move(direction, spaceship.get_acceleration_curve(), spaceship.get_speed());
	
	return velocity;

#####
# Function: handle_shooting()
#
# This will make the ship look towards the mouse on click and shoot a bullet towards the looking
# direction
# 
# Returns: -
#
####
func handle_shooting():
	if(Input.is_action_pressed("mouse_left")):
		
		var result = raycast_from_mouse();
		
		rotate_with_mouse = true;
		if(result.has('position')):
			var aim_direction = (self.global_transform.origin - result.position).normalized();
			self.look_at_smooth(aim_direction, 1);
			aim_timer.start();
			emit_signal("shoot", -Vector3(aim_direction.x, 0, aim_direction.z), [Groups.Player]);
		pass
	pass

#####
# Function: emit_fire_particle()
#
# Emits the fire particle trail behind the ship
# 
# Returns: -
#
####
func emit_fire_particle():
	if(direction.length() > 0):
		emit_signal("thrust", true);
		pass
	else:
		emit_signal("thrust", false);
	pass

#####
# Function: raycast_from_mouse()
# 
# Returns: The collisionshape that the raycast manages to hit (aka the result)
#
####
func raycast_from_mouse():
	var from : Vector3 = camera.project_ray_origin(get_viewport().get_mouse_position());
	var to : Vector3 = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000;
	var space_state : PhysicsDirectSpaceState = get_world().get_direct_space_state();
	var result : Dictionary = space_state.intersect_ray(from, to, [], 0x80000, false, true);
	
	return result;

# Function: equip_spaceship()
# 
# Connects a spaceship to the player
#
# Returns: -
#
####
func equip_spaceship(var spaceship : Spaceship):
	self.spaceship = spaceship;
	self.connect("thrust", spaceship, "set_thrust_state");
	self.connect("shoot", spaceship, "_on_host_shoot");
	spaceship.connect("has_shot", self, "on_has_shot");
	pass

#####
# Function: _on_AimTimer_timeout()
#
# This is to make it so that the player looks in the moving direction and not the aiming direction
# After a period of time defined by the aimtimer
#
# Returns: -
#
####
func _on_AimTimer_timeout():
	rotate_with_mouse = false;
	pass
	
func on_has_shot():
	sfx_pew.play();
	pass
	
func on_hit():
	pass
