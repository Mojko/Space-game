extends Node

const SCENE_01_GAME = "res://scenes/game_scene/game.tscn";
const SCENE_02_LEVEL_SELECT = "res://scenes/level_select/level_select.tscn";

var current_scene = null

func _ready():
	var root = get_tree().get_root();
	current_scene = root.get_child(root.get_child_count() - 1);

func load_scene(scene_path : String, scene_data : Array = []):
	print("Loading scene ", scene_path);
	call_deferred("_goto_scene", scene_path, scene_data);

func _goto_scene(scene_path, scene_data):
	print(current_scene.name);
	current_scene.free();

	var interactive_loader = ResourceLoader.load_interactive(scene_path);
	while(interactive_loader.poll() != ERR_FILE_EOF):
		print("...");

	var next_scene = interactive_loader.get_resource().instance();

	get_tree().get_root().add_child(next_scene);

	get_tree().set_current_scene(next_scene);

	if(next_scene.has_method("load_scene")):
		next_scene.load_scene(scene_data);
		
	current_scene = next_scene;
		
	print("Successfully loaded scene");