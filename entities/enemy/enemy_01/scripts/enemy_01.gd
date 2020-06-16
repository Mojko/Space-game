extends KinematicBody

signal spawn_projectile(from, direction, invulnerables);
signal hit(entity);
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
	emit_signal("hit", self);
	
	spaceship.health -= 1;
	if(spaceship.health <= 0):
		emit_signal("death", self);
		queue_free();
	
#####
# Function: _on_attacking_shoot(from, direction, inv)
#
# This is what will communicate out to the projectile pool to spawn a pool when "attacking"
# wants to shoot a target
#
# Returns: -
#
####
func _on_attacking_shoot(direction, invulnerables):
	for weapon_slot in spaceship.loadout.get_weapon_slots():
		if(weapon_slot.has_weapon()):
			emit_signal("spawn_projectile", weapon_slot, direction, invulnerables);