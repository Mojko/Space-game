extends Entity
class_name Player

export(NodePath) var camera_path;

signal hit(who);
signal thrust(state);
signal shoot(from, direction, invulnerables);

onready var camera : Camera = get_node(camera_path);
onready var aim_timer : Timer = get_node("aim_timer");
onready var sfx_pew : AudioStreamPlayer = get_node("pew");
onready var shooting : Node = get_node("shooting");

var spaceship : Spaceship;
var direction : Vector3 = Vector3();
var rotate_with_mouse : bool = false;
var can_shoot : bool = false;

func _ready():
	get_tree().call_group("spawn_listener", "player_has_spawned", self);

func _physics_process(delta):
	
	var velocity = handle_movement();
	emit_fire_particle();
	handle_shooting();
		
	#Look towards where you're going
	if(rotate_with_mouse == false and direction.length() > 0):
		PhysicsHelper.look_at_smooth(self, -direction, 0.2);
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
	
	var is_moving = false;
	
	if(Input.is_action_pressed("move_up")):
		direction.z += -1;
		direction.x += 2;
		is_moving = true;
		pass
	if(Input.is_action_pressed("move_right")):
		direction.x += 1;
		direction.z += 2;
		is_moving = true;
		pass
	if(Input.is_action_pressed("move_left")):
		direction.x += -1;
		direction.z += -2;
		is_moving = true;
		pass
	if(Input.is_action_pressed("move_down")):
		direction.z += 1;
		direction.x += -2;
		is_moving = true;
		pass
		
	var moving_direction = direction;
		
	if(is_moving):
		if(aim_timer.time_left <= 0):
			moving_direction = -get_global_transform().basis.z;
		accelerate();
	else:
		deaccelerate();
		
	var velocity = move(moving_direction, spaceship.get_speed(), spaceship.get_acceleration_curve());
	
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
		
		var result = RayCastHelper.raycast_from_mouse(camera);
		
		rotate_with_mouse = true;
		if(result.has('position')):
			var aim_direction = (self.global_transform.origin - result.position).normalized();
			PhysicsHelper.look_at_smooth(self, aim_direction, 1);
			
			aim_timer.start();
			spaceship.loadout.shooting_behaviour.shoot(aim_direction);
			
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
		emit_signal("thrust", true);
		pass
	else:
		emit_signal("thrust", false);
	pass

# Function: equip_spaceship(spaceship)
# 
# Connects a spaceship to the player
#
# Returns: -
#
####
func equip_spaceship(var spaceship : Spaceship):
	self.spaceship = spaceship;
	self.connect("thrust", spaceship, "set_thrust_state");
	spaceship.connect("has_shot", self, "on_has_shot");
	pass

# Function: on_hit()
# 
# Ran when the player is hit by bullet
#
# Returns: -
#
####
func on_hit(source):
	emit_signal("hit", self);
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