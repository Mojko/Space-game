extends Spatial

var current_weapon : Dictionary;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func equip_weapon(var weapon : Dictionary):
	self.current_weapon = weapon;
	pass
	
func has_weapon() -> bool:
	return !self.current_weapon.empty();