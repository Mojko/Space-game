extends Camera

var start_position : Vector3;

func _ready():
	start_position = self.global_transform.origin;

func _on_player_move(new_position):
	self.global_transform.origin = start_position + new_position;
