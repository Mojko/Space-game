extends Label

func _on_preview_container_preview_cost(cost):
	self.text = "Cost: " + str(cost);
