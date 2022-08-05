extends Area2D
class_name PowerUp


func _on_PowerUp_body_entered(body):
	if body.is_in_group("Player"):
		power_up(body)

func power_up(body):
	pass


func _on_Timer_timeout():
	queue_free()
