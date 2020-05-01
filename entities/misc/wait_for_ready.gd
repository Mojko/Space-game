extends Spatial

signal is_ready();

func _ready():
	connect("is_ready", get_parent(), "on_children_ready");
	emit_signal("is_ready");
