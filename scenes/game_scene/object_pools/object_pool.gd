extends Node
class_name ObjectPool

export(PackedScene) var objectToPool;

var pool : Array = []; #Spatial array

func create_instance() -> Spatial:
	var instance = objectToPool.instance();
	add_child(instance);
	return instance;

func add_to_pool(object : Spatial) -> void:
	object.global_transform.origin = Vector3(0, 0, 1);
	object.set_process(false);
	object.hide();
	pool.append(object);
	
func spawn_object_from_pool(position : Vector3) -> Spatial:
	if(pool.size() <= 30 or pool.front() == null):
		expand(50);
		pass
		
	var instance : Spatial = pool.pop_front();
	instance.global_transform.origin = position;
	instance.set_process(true);
	instance.show();
	return instance;
	
func expand(size):
	print("This has to be overriden by child ", self);