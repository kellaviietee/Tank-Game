extends Node

var high_score = 0
onready var label:Label = get_tree().get_nodes_in_group("HighScoreLabel")[0]

func _ready():
	add_to_score(0)

func add_to_score(amount:int)->void:
	high_score += amount
	label.text = "High Score \n " + str(high_score)
