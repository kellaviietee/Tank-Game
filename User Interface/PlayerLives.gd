extends Node

onready var player_spawner:PlayerSpawner = get_tree().get_nodes_in_group("PlayerSpawner")[0]
onready var player_lives_label:Label = get_tree().get_nodes_in_group("PlayerlivesLabel")[0]
var lives:int = 3


func add_lives(amount:int) -> void:
	lives += amount
	player_lives_label.text = "Player Lives \n " + str(lives)

func remove_lives(amount:int) -> void:
	lives -= amount
	player_lives_label.text = "Player Lives \n " + str(lives)
	if lives > 0:
		player_spawner.spawn()
