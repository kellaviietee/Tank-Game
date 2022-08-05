extends Area2D




func _on_Flag_area_entered(area):
	if get_tree().get_nodes_in_group("Bullet").has(area):
		print("Game Over")
