extends Node

enum Id {
	spaceship_0_noob,
	spaceship_2,
	laser_00
};

enum Type {
	SPACESHIP,
	LASER
};

func to_equipment_id(shop_item_id):
	match shop_item_id:
		ShopItemId.Id.spaceship_0_noob:
			return SpaceshipId.Id.spaceship_0_noob;
			
		ShopItemId.Id.spaceship_2:
			return SpaceshipId.Id.spaceship_2;
			
		ShopItemId.Id.laser_00:
			pass
	pass