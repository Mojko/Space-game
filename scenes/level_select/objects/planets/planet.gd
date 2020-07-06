extends Spatial

export(String) var planet_name;
export(int, 1, 5) var planet_rank;

signal travel_here(planet, position);

onready var planet = get_node("planet");
onready var outline = get_node("outline");
onready var travel_to = get_node("travel_to");
onready var ranking = get_node("ranking");

var mouse_has_entered = false;
var selected = false;

func _ready():
	dehighlight();
	ranking.set_rank(planet_rank);

func _process(delta):
	if(!mouse_has_entered):
		return;
	
	if(Input.is_action_just_pressed("mouse_left")):
		emit_signal("travel_here", self, travel_to.global_transform.origin);

func _on_area_mouse_entered():
	mouse_has_entered = true;
	
	if(selected):
		return;
		
	highlight_half();
	
func _on_area_mouse_exited():
	mouse_has_entered = false;
	
	if(selected):
		return;
		
	dehighlight();

func highlight():
	planet.material_override.albedo_color = Color(1, 1, 1, 1);
	outline.material_override.albedo_color = Color(1, 1, 1, 1);
	
func highlight_half():
	planet.material_override.albedo_color = Color(0.75, 0.75, 0.75, 1);
	outline.material_override.albedo_color = Color(0.4, 0.4, 0.4, 0.4);
	
func dehighlight():
	planet.material_override.albedo_color = Color(0.5, 0.5, 0.5, 1);
	outline.material_override.albedo_color = Color(0.2, 0.2, 0.2, 1);

func select():
	highlight();
	selected = true;
	
func deselect():
	if(!selected):
		return;
		
	dehighlight();
	selected = false;