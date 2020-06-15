extends Node
class_name ObjectPool

export(PackedScene) var objectToPool;

var pool : Array = []; #Spatial array

func create_instance() -> Spatial:
	var instance = objectToPool.instance();
	add_child(instance);
	return instance;

func add_to_pool(object : Spatial) -> void:
	object.global_transform.origin = Vector3(999, 999, 999);
	object.set_process(false);
	pool.append(object);
	
func spawn_object_from_pool(position : Vector3) -> Spatial:
	if(pool.size() <= 30 or pool.front() == null):
		expand();
		pass
		
	var instance : Spatial = pool.pop_front();
	instance.global_transform.origin = position;
	instance.set_process(true);
	return instance;
	
func expand():
	print("This has to be overriden by child");