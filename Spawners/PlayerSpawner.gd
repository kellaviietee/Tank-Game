extends Spawner
class_name PlayerSpawner

func _ready():
	spawn()

func spawn():
	anim.play("spawning")

func add_characters() -> void:
	var new_enemy = enemy_1.instance()
	new_enemy.position = position
	map.call_deferred("add_child",new_enemy)
	
