extends Node

func _on_preview_container_preview_3d_model(model_name):
	for child in $spinner.get_children():
		child.visible = false;

	if($spinner.get_node(model_name) != null):
		$spinner.get_node(model_name).visible = true;