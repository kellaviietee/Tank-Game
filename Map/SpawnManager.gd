extends Node
class_name SpawnManager

signal enemy_spawned
var total_enemies = 0
var current_spawner = 0
onready var info = get_tree().get_nodes_in_group("EnemyInfo")[0]

func _ready():
	var err = connect("enemy_spawned",info,"_on_SpawnManager_enemy_spawned")
	if err != OK:
		print("Failure!")



func _on_SpawnTimer_timeout():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if enemies.size() >= 5 or total_enemies == 20:
		return
	var spawner:Spawner = get_child(current_spawner)
	spawner.spawn()
	current_spawner = (current_spawner + 1) % 3
	total_enemies += 1
	emit_signal("enemy_spawned")
