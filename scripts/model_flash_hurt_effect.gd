extends MeshInstance

export(Resource) var hurt_material;

onready var original_material = get_surface_material(0);

var can_flash : bool = true;

func _ready():
	var timer = Timer.new();
	timer.connect("timeout", self, "_on_timer_timeout");
	add_child(timer);
	timer.start(0.4);

func _on_model_flash():
	if(!can_flash):
		return;
		
	set_surface_material(0, hurt_material);
	can_flash = false;
	
func _on_timer_timeout():
	set_surface_material(0, original_material);
	can_flash = true;