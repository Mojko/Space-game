extends Camera

signal raycast_shoot(result);

var start_position : Vector3;

func _ready():
	start_position = self.global_transform.origin;
	
func _process(delta):
	_raycast_shoot();

func _on_player_move(new_position):
	self.global_transform.origin = start_position + new_position;
	
func _raycast_shoot():
	if(Input.is_action_pressed("mouse_left")):
		var result = RayCastHelper.raycast_from_mouse(self);
		
		if(result.has("position")):
			emit_signal("raycast_shoot", result);