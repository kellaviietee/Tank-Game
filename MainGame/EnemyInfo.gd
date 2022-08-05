extends Control
class_name EnemyInfo

func _on_SpawnManager_enemy_spawned():
	var enemies_icons = $Panel/VBoxContainer/EnemiesLeft.get_children()
	var first_enemy = enemies_icons[0]
	first_enemy.queue_free()
