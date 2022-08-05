extends Node
class_name PowerUpManager

export(PackedScene) var TankUpgrade
export(PackedScene) var Grenade
export(PackedScene) var Shield

var all_locations = []
onready var PowerUps:Array = [TankUpgrade,Grenade,Shield]
onready var map:TileMap = get_parent()

func _ready():
	for x in 13:
		for y in 13:
			all_locations.append(Vector2(x,y))
	

func add_power_up():
	var power_ups = get_tree().get_nodes_in_group("PowerUp")
	if power_ups:
		return
	randomize()
	PowerUps.shuffle()
	var new_power_up:PowerUp = PowerUps[0].instance()
	all_locations.shuffle()
	new_power_up.position = map.map_to_world(all_locations[0])
	map.call_deferred("add_child",new_power_up)
	
	
