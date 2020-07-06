extends Spatial

func set_rank(rank):
	for i in rank:
		self.get_child(i).frame = 1;