extends Spatial

export(NodePath) var loadout_path;

onready var loadout = get_node(loadout_path);

func _ready():
	loadout.equip_weapon(0, Weapons.get_weapon(Weapons.Types.LF0));
	loadout.equip_weapon(1, Weapons.get_weapon(Weapons.Types.LF0));
	pass