extends KinematicBody
class_name Entity

signal i_have_spawned(entity);

var acceleration_curve_x : float = 0;

func _ready():
	emit_signal("i_have_spawned", self);

#####
# Function: move(direction, acceleration_curve, speed)
#
# Moves the entity using acceleration curve
# 
# Returns: -
#
####
func move(var direction : Vector3, var acceleration_curve : Curve, var speed : float) -> Vector3:
	accelerate(direction);
	var velocity = move_and_slide(direction.normalized() * acceleration_curve.interpolate(acceleration_curve_x) * speed, Vector3.UP);
	return velocity;

#####
# Function: accelerate(direction)
#
# Accelerates the entity. Doesn't have to be used outside the Entity class. Used in move()
# 
# Returns: -
#
####
func accelerate(var direction : Vector3):
	if(direction.length() > 0):
		acceleration_curve_x += 0.01;
		if(acceleration_curve_x >= 1):
			acceleration_curve_x = 1;
	else:
		acceleration_curve_x = 0;
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