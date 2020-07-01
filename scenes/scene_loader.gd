extends Node

const SCENE_01_GAME = "res://scenes/game_scene/game.tscn";
const SCENE_02_LEVEL_SELECT = "res://scenes/level_select/level_select.tscn";

var current_scene = null

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)
	
#func _deferred_goto_scene(path):
#    # It is now safe to remove the current scene
#    current_scene.free()
#
#    # Load the new scene.
#    var s = ResourceLoader.load(path)
#
#    # Instance the new scene.
#    current_scene = s.instance()
#
#    # Add it to the active scene, as child of root.
#    get_tree().get_root().add_child(current_scene)
#
#    # Optionally, to make it compatible with the SceneTree.change_scene() API.
#    get_tree().set_current_scene(current_scene)

func load_scene(scene_path : String, scene_data : Array = []):
	print("Loading scene ", scene_path);
	call_deferred("_goto_scene", scene_path, scene_data);

func _goto_scene(scene_path, scene_data):
	current_scene.free();

	var interactive_loader = ResourceLoader.load_interactive(scene_path);
	while(interactive_loader.poll() != ERR_FILE_EOF):
		print("...");

	var next_scene = interactive_loader.get_resource().instance();

	get_tree().get_root().add_child(next_scene);

	get_tree().set_current_scene(next_scene);

	if(next_scene.has_method("load_scene")):
		next_scene.load_scene(scene_data);
		
	print("Successfully loaded scene");