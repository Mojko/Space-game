extends Node

func preview(preview_path):
	for child in $spinner.get_children():
		child.visible = false;

	if($spinner.get_node(preview_path) != null):
		$spinner.get_node(preview_path).visible = true;