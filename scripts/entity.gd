extends KinematicBody
class_name Entity

var last_moving_direction : Vector3 = Vector3();
var acceleration_curve_x : float = 0;
var velocity : Vector3 = Vector3();

#####
# Function: move(direction, acceleration_curve, speed)
#
# Moves the entity using acceleration curve
# 
# Returns: -
#
####
func move(var direction : Vector3, var speed : float, var acceleration_curve : Curve = null) -> Vector3:
	
	if(direction.length() > 0):
		last_moving_direction = direction;
	
	var vel = Vector3();
	
	var acceleration = acceleration_curve.interpolate(acceleration_curve_x);
	
	var final_velocity = Vector3();
	
	final_velocity = last_moving_direction.normalized() * acceleration * speed;
	
	vel = move_and_slide(final_velocity, Vector3.UP);
	velocity = vel;	
	return vel;

#####
# Function: deaccelerate()
#
# Deaccelerates the entity. Doesn't have to be used outside the Entity class. Used in move()
# 
# Returns: -
#
####
func deaccelerate():
	acceleration_curve_x -= 0.03;
	
	if(acceleration_curve_x <= 0):
		acceleration_curve_x = 0;
	pass

#####
# Function: accelerate()
#
# Accelerates the entity. Doesn't have to be used outside the Entity class. Used in move()
# 
# Returns: -
#
####
func accelerate():
	acceleration_curve_x += 0.05;
	
	if(acceleration_curve_x >= 1):
		acceleration_curve_x = 1;
	pass
	
func get_velocity():
	return velocity;