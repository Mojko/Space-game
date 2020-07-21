extends Node

func to_node_array(origin_node : Node, paths_array : Array) -> Array:
	var node_array : Array = [];
	for path in paths_array:
		node_array.append(origin_node.get_node(path));
		
	return node_array;