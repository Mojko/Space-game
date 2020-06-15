extends Spatial

#####
# Function: raycast_from_mouse()
# 
# Returns: The collisionshape that the raycast manages to hit (aka the result)
#
####
func raycast_from_mouse(camera):
	var from : Vector3 = camera.project_ray_origin(get_viewport().get_mouse_position());
	var to : Vector3 = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000;
	var space_state : PhysicsDirectSpaceState = get_world().get_direct_space_state();
	var result : Dictionary = space_state.intersect_ray(from, to, [], 0x80000, false, true);
	return result;