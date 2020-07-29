extends VBoxContainer

signal preview_3d_model(model_name);
signal preview_cost(cost);

var current_previewed_item;

func preview_item(item):
	self.current_previewed_item = item;
	_update_current_previewed_item();
	
	print("Previewing item: ", item.preview_model_name);
	emit_signal("preview_3d_model", item.preview_model_name);
	emit_signal("preview_cost", item.cost);

func _on_purchase_button_pressed():
	match current_previewed_item.type:
		ShopItemId.Type.SPACESHIP:
			GlobalPlayerData.add_owned_ship(ShopItemId.to_equipment_id(current_previewed_item.id));
		
	_update_current_previewed_item();
			
func _on_equip_button_pressed():
	match current_previewed_item.type:
		ShopItemId.Type.SPACESHIP:
			GlobalPlayerData.equip_ship(ShopItemId.to_equipment_id(current_previewed_item.id));
		
	_update_current_previewed_item();

func _update_current_previewed_item():
	_enable_purchase_button();
	
	match current_previewed_item.type:
		ShopItemId.Type.SPACESHIP:
			if(GlobalPlayerData.owns_ship(ShopItemId.to_equipment_id(current_previewed_item.id))):
				_enable_equip_button();
			if(GlobalPlayerData.has_ship_equipped(ShopItemId.to_equipment_id(current_previewed_item.id))):
				_enable_equipped_button();
			
func _enable_equipped_button():
	_hide_all_buttons();
	$equipped_button.show();
	
func _enable_equip_button():
	_hide_all_buttons();
	$equip_button.show();
	
func _enable_purchase_button():
	_hide_all_buttons();
	$purchase_button.show();
	
func _hide_all_buttons():
	$purchase_button.hide();
	$equip_button.hide();
	$equipped_button.hide();
