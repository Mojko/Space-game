extends ColorRect

var center;
var target;
var minX;
var minY;
var maxX;
var maxY;

func _process(delta):
	if(self.center != null and self.target != null):
		var difference = center.global_transform.origin - target.global_transform.origin;
		rect_position = Vector2(90 - ((difference.x + difference.z * 2)) * 2, 80 - ((difference.z - difference.x * 2)) * 2);
		#print(rect_position);
		check_bounds();
	
func check_bounds():
	if(rect_position.x >= maxX):
		rect_position.x = maxX;
	if(rect_position.x <= minX):
		rect_position.x = minX;
	if(rect_position.y >= maxY):
		rect_position.y = maxY;
	if(rect_position.y <= minY):
		rect_position.y = minY;
	pass

func set_bounds(minX, minY, maxX, maxY):
	self.minX = minX;
	self.minY = minY;
	self.maxX = maxX - rect_size.x;
	self.maxY = maxY - rect_size.y;
	

func attach(entity):
	self.target = entity;
	pass

func attach_center(entity):
	self.center = entity;
	pass