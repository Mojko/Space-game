extends Entity
class_name Player

signal move(new_position);
signal shoot(laser_data, from, direction, invulnerables);
signal hit(type, who);
signal hit_electricity(who);

onready var aim_timer : Timer = get_node("aim_timer");
onready var shooting_behaviour : Node = get_node("player_shooting_behaviour");

var spaceship;
var direction : Vector3 = Vector3();
var rotate_with_mouse : bool = false;
var can_shoot : bool = false;

func _ready():
	get_tree().call_group("spawn_listener", "player_has_spawned", self);

func _physics_process(delta):
	
	handle_movement();
	emit_fire_particle();
#	handle_shooting();
	
	#Look towards where you're going
	if(rotate_with_mouse == false and direction.length() > 0):
		PhysicsHelper.look_at_smooth(self, -direction, 0.2);

#####
# Function: handle_movement()
#
# Returns: velocity of movement
#
####
func handle_movement() -> void:
	direction = Vector3();
	
	var is_moving = false;
	
	if(Input.is_action_pressed("move_up")):
		direction.z += -1;
		#direction.x += 2;
		is_moving = true;
		pass
	if(Input.is_action_pressed("move_right")):
		direction.x += 1;
		#direction.z += 2;
		is_moving = true;
		pass
	if(Input.is_action_pressed("move_left")):
		direction.x += -1;
		#direction.z += -2;
		is_moving = true;
		pass
	if(Input.is_action_pressed("move_down")):
		direction.z += 1;
		#direction.x += -2;
		is_moving = true;
		pass
		
	var moving_direction = direction;
		
	if(is_moving):
		if(aim_timer.time_left <= 0):
			moving_direction = -get_global_transform().basis.z;
		accelerate();
	else:
		deaccelerate();
		
	move(moving_direction, spaceship.get_speed(), spaceship.get_acceleration_curve());
	emit_signal("move", global_transform.origin);

#####
# Function: handle_shooting()
#
# This will make the ship look towards the mouse on click and shoot a bullet towards the looking
# direction
# 
# Returns: -
#
####
#func handle_shooting():
#	if(Input.is_action_pressed("mouse_left")):
#
#		var result = RayCastHelper.raycast_from_mouse(camera);
#
#		rotate_with_mouse = true;
#		if(result.has('position')):

			
#####
# Function: emit_fire_particle()
#
# Emits the fire particle trail behind the ship
# 
# Returns: -
#
####
func emit_fire_particle():
	if(get_velocity().length() > 3.5):
		spaceship.set_thrust_state(true);
	else:
		spaceship.set_thrust_state(false);

# Function: equip_spaceship(spaceship)
# 
# Connects a spaceship to the player
#
# Returns: -
#
####
func _on_spaceship_repository_equip_spaceship(spaceship):
	self.spaceship = spaceship;
	self.spaceship.connect("shoot", self, "_on_spaceship_shoot");
	self.spaceship.activate();
	$CollisionShape.shape = self.spaceship.get_collision_shape();

# Function: on_hit(source)
# 
# Ran when the player is hit by bullet
#
# Returns: -
#
####
func on_hit(source, damage):
	emit_signal("hit", Hit.Type.DEFAULT,self);
	
# Function: on_hit_electricity(source)
# 
# Ran when the player is hit by a electricity source
#
# Returns: -
#
####
func on_hit_electricity(source, damage):
	emit_signal("hit", Hit.Type.ELECTRICITY, self);
	
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
	
#####
# Function: _on_raycast_shoot(result)
#
# When the left mouse button is pressed the camera will send out a signal if
# a raycast has been hit
#
# Returns: -
#
####
func _on_raycast_shoot(result):
	var aim_direction = (self.global_transform.origin - result.position).normalized();
	PhysicsHelper.look_at_smooth(self, aim_direction, 1);
	
	aim_timer.start();
	spaceship.loadout.shoot();
	rotate_with_mouse = true;
	
func _on_spaceship_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction, [Groups.Player]);