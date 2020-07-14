extends ScrollContainer

func init():
	$grid.get_child(0).emit_signal("pressed");