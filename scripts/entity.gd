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

#####
# Function: look_at_smoth(dir, slerp_speed(0,1))
#
# Looks towards direction using slerp with the speed slerp_speed (between 0 and 1)
# 
# Returns: -
#
####
func look_at_smooth(var dir : Vector3, var slerp_speed : float):
	var look_dir = global_transform.origin - dir;
	var rot = self.global_transform.looking_at(look_dir, Vector3(0,1,0))
	var quatRot = Quat(self.global_transform.basis).slerp(rot.basis, slerp_speed);
	self.set_transform(Transform(Quat(self.rotation.x, quatRot.y, self.rotation.z, quatRot.w), self.global_transform.origin))
	pass
	
func get_velocity():
	return velocity;