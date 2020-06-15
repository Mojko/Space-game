extends Spatial

onready var player = get_node("player");
onready var laser_pool = get_node("pools/laser_pool");

func _ready():
	player.shooting_system.connect("shoot", laser_pool, "on_entity_shoot");