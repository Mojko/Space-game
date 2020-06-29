extends Spatial

signal teleport_jump();

var can_jump = false;

func _process(delta):
	if(can_jump and Input.is_action_just_pressed("teleport_jump")):
		print("Teleporting!");
		emit_signal("teleport_jump");

func _on_area_body_entered(body):
	print("Entered", body.name);
	if(body.is_in_group(Groups.Player)):
		can_jump = true;
	
func _on_area_body_exited(body):
	print("Exited ", body.name);
	if(body.is_in_group(Groups.Player)):
		can_jump = false;