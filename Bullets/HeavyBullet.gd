extends Bullet

func bullet_collided(body):
	if get_tree().get_nodes_in_group("Enemy").has(body) and (get_tree().get_nodes_in_group("Enemy").has(from_tank) or not is_instance_valid(from_tank)):
		pass
	elif get_tree().get_nodes_in_group("Player").has(body) and (get_tree().get_nodes_in_group("Player").has(from_tank) or not is_instance_valid(from_tank)):
		pass
	elif get_tree().get_nodes_in_group("Tank").has(body):
		body.queue_free()
		free_bullet()
	elif get_tree().get_nodes_in_group("Map").has(body):
		free_bullet()
	elif get_tree().get_nodes_in_group("Wood").has(body):
		body.queue_free()
		free_bullet()
	elif get_tree().get_nodes_in_group("Iron").has(body):
		body.queue_free()
		free_bullet()
