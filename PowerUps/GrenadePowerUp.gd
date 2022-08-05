extends PowerUp

func power_up(body):
	get_tree().call_group("Enemy","explode")
	queue_free()
