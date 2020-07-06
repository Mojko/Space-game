extends Label

export(Curve) var acceleration_curve;

onready var tween = get_node("Tween");

var camera : Camera;
var position_3d : Vector3;
var acceleration_curve_position_x : float = 0;

func _ready():
	var random = randi() % 1337;
	text = str(random);
	position_3d.y += 4;
	tween.interpolate_property(self, "self_modulate", Color(1, 1, 1, 1), Color(0, 0, 0, 0), 4, Tween.TRANS_BACK, Tween.EASE_OUT);
	tween.start();

func position_in_world(camera : Camera, position_3d : Vector3):
	self.camera = camera;
	self.position_3d = position_3d;

func _process(delta):
	
	#self_modulate = Color(1, 1, 1, 0);
	
	rect_position = camera.unproject_position(position_3d);
	rect_position.x = rect_position.x - rect_size.x;
	position_3d.y += acceleration_curve.interpolate(acceleration_curve_position_x) * delta * 4;
	acceleration_curve_position_x += 1 * delta;
	
func _on_death_timer_timeout():
	queue_free();
