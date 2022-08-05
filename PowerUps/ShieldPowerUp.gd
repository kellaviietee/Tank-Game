extends PowerUp

func power_up(body:PlayerTank):
	body.shield.restart()
	queue_free()
