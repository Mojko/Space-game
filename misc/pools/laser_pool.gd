extends Spatial

export(PackedScene) var laser_model : PackedScene;

var pool : Array = []; #Spatial array
var activeLasers : int = 0;

func _ready():
	for i in 100:
		var instance = laser_model.instance();
		instance.global_transform.origin = Vector3(999, 999, 999);
		instance.set_process(false);
		self.add_child(instance);
		pool.append(instance);
		
func spawn_laser(position : Vector3) -> Spatial:
	var instance : Spatial = pool.front();
	instance.global_transform.origin = position;
	instance.set_process(true);
	activeLasers += 1;
	return instance;
	
func despawn_laser(instance : Spatial) -> void:
	instance.global_transform.origin = Vector3(999, 999, 999);
	instance.set_process(false);
	activeLasers -= 1;
	pass

func _on_entity_shoot(direction, invulnerables):
	pass
