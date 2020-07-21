extends Spatial

func _on_player_move(new_position):
	self.global_transform.origin = new_position;