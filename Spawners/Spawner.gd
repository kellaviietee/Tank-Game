extends Area2D
class_name Spawner

export(PackedScene) var enemy_1
export(PackedScene) var enemy_2
export(PackedScene) var enemy_3
onready var enemies:Array = [enemy_1,enemy_2, enemy_3]
onready var map:TileMap = get_tree().get_nodes_in_group("Map")[0]
onready var anim:AnimationPlayer = $AnimationPlayer
onready var enemy_list:Array = get_tree().get_nodes_in_group("EnemiesLeft")[0].level_enemies

func spawn() -> void:
	if get_overlapping_bodies().size() == 0:
		anim.play("spawning")

func add_characters() -> void:
	var random_nr = enemy_list[0]
	var random_enemy = enemies[random_nr]
	var new_enemy:EnemyTank = random_enemy.instance()
	new_enemy.position = position
	var coin_flip = randi() % 2
	map.add_child(new_enemy)
	if coin_flip == 0:
		new_enemy.gives_power_up = true
		new_enemy.body_animator.play("flash_color")
	enemy_list.remove(0)
	
