extends Node

enum Type {
	DEFAULT,
	ELECTRICITY,
	BOLTS_NUTS
}

func parse(hit_type_str : String):
	if(hit_type_str == "DEFAULT"):
		return Type.DEFAULT;
	if(hit_type_str == "ELECTRICITY"):
		return Type.ELECTRICITY;
	if(hit_type_str == "NUTS_BOLTS"):
		return Type.BOLTS_NUTS;