extends KinematicBody

export(String, "DEFAULT", "ELECTRICITY", "NUTS_BOLTS") var hit_type;

signal shoot(laser_data, from, direction, invulnerables);
signal hit(type, entity);
signal death(entity);

onready var state_machine = get_node("state_machine");
onready var spaceship = get_node("spaceship");

var speed : float = 2;

#####
# Function: _ready()
#
# Returns: -
#
####
func _ready():
	get_tree().call_group("spawn_listener", "alien_have_spawned", self);
	
	var nodes = get_tree().get_nodes_in_group("friendly");
	
	if(nodes.size() <= 0):
		return;
	
	var target = nodes[randi() % nodes.size()];
	state_machine.change_state('chasing', [target]);
	
#####
# Function: _physics_process(delta)
#
# Returns: -
#
####
func _physics_process(delta):
	state_machine.physics_update(self);
	
#####
# Function: on_hit(source)
#
# Returns: -
#
####
func on_hit(source):
	emit_signal("hit", Hit.parse(hit_type), self);
	
	spaceship.health -= 1;
	if(spaceship.health <= 0):
		emit_signal("death", self);
		queue_free();
		
#####
# Function: _on_attacking_shoot(laser_data, from, direction)
#
# Returns: -
#
####
func _on_attacking_shoot(laser_data, from, direction):
	emit_signal("shoot", laser_data, from, direction, [Groups.Enemy]);
