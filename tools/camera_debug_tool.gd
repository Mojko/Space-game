extends Spatial

export(NodePath) var camera_path : NodePath;

onready var camera = get_node(camera_path) : Camera;

