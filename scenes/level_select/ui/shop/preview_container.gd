extends VBoxContainer

export(NodePath) var shop_item_3d_preview_container_path;
export(NodePath) var text_cost_path;


onready var shop_item_3d_preview_container = get_node(shop_item_3d_preview_container_path);
onready var text_cost = get_node(text_cost_path);

func preview_item(item):
	print("Previewing item: ", item.preview_model_name);
	shop_item_3d_preview_container.preview(item.preview_model_name);
	text_cost.preview(item.cost);