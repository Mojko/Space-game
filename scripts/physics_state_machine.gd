extends Node

export(Array, String) var state_map = [];

var states = [];
var active_state;

func _ready():
	for child in get_children():
		states.append(child);
		
func physics_update(parent):
	if(active_state == null):
		return;
	
	var next_state_data : Array = active_state.physics_update(parent);
	
	if(next_state_data != null):
		var next_state = next_state_data.pop_front();
		change_state(next_state, next_state_data);
		
func change_state(next_state : String, data : Array):
#	print("Changed state to (", next_state, ")");
	var index = state_map.find(next_state);
	active_state = states[index];
	active_state.init(data);