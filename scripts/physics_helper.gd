extends Node

#####
# Function: look_at_smoth(dir, slerp_speed(0,1))
#
# Looks towards direction using slerp with the speed slerp_speed (between 0 and 1)
# 
# Returns: -
#
####
func look_at_smooth(me : Spatial, dir : Vector3, slerp_speed : float):
	var look_dir = me.global_transform.origin - dir;
	var rot = me.global_transform.looking_at(look_dir, Vector3(0,1,0))
	var quatRot = Quat(me.global_transform.basis).slerp(rot.basis, slerp_speed);
	me.set_transform(Transform(Quat(me.rotation.x, quatRot.y, me.rotation.z, quatRot.w), me.transform.origin))