extends GridContainer
class_name EnemiesLeft

export(PackedScene) var enemy_1
export(PackedScene) var enemy_2
export(PackedScene) var enemy_3
onready var enemy_types:Array = [enemy_1,enemy_2, enemy_3] 
var level_enemies = []
func _ready():
	for number in 20:
		randomize()
		var enemy_type = randi() % enemy_types.size()
		add_child(enemy_types[enemy_type].instance())
		level_enemies.append(enemy_type)

func enemies_left():
	if not level_enemies.size() and get_tree().get_nodes_in_group("Enemy").size() == 1:
		print("last enemy killed")
