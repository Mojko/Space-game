extends TextureRect

var target;

func _process(delta):
	if(target != null):
		rect_rotation = -target.get_rotation_degrees().y - 60;
	
	pass

func attach(target):
	self.target = target;
	
func get_attachment():
	return target;