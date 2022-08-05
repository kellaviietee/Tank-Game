extends AnimatedSprite
class_name Explosion


func _on_Explosion_animation_finished():
	queue_free()
