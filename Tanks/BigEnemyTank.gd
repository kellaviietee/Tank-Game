extends EnemyTank
class_name BigEnemyTank
var health = 3
onready var anim:AnimationPlayer = $Body/AnimationPlayer

func _ready():
	anim.play("color_1")

func get_hit() -> void:
	if gives_power_up:
		power_up_manager.add_power_up()
		gives_power_up = false
		body_animator.stop()
	if health == 0:
		if is_instance_valid(shot_bullet):
			shot_bullet.queue_free()
		emit_signal("dying")
		HighScore.add_to_score(100)
		explode()
	health -= 1
	match health:
		2: anim.play("color_2")
		1: anim.play("color_3")
		0: $Body/overlay.visible = false
