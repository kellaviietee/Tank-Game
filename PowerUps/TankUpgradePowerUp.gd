extends PowerUp

func power_up(body:PlayerTank):
	var current_level = body.get_tank_level()
	body.set_tank_level(current_level + 1)
	queue_free()
