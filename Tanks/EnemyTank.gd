extends Tank
class_name EnemyTank

signal dying
var change_dir:bool = true
var current_dir: Vector2 = Vector2.ZERO
var is_on_cooldown:bool = true
var gives_power_up:bool = false
onready var cooldownTimer:Timer = $CooldownTimer
onready var body_animator:AnimationPlayer = $Body/AnimationPlayer
onready var power_up_manager:PowerUpManager = get_tree().get_nodes_in_group("PowerUpManager")[0]
onready var enemy_counter:EnemiesLeft = get_tree().get_nodes_in_group("EnemiesLeft")[0]

func _ready():
	connect("dying",enemy_counter,"enemies_left")

func tank_control(delta:float)->Vector2:
	if change_dir:
		change_dir = false
		find_new_direction()
	if can_shoot and not is_on_cooldown:
		shoot()
		is_on_cooldown = true
		cooldownTimer.start()
	return current_dir * speed

func change_direction():
	change_dir = true

func find_new_direction()->void:
	randomize()
	var random_dir = randi() % 6
	$Timer.wait_time =  1 * randf()
	$Timer.start()
	if random_dir == 0:
		adjust_position(Vector2.UP)
		current_dir = Vector2.UP
	elif random_dir == 1:
		adjust_position(Vector2.RIGHT)
		current_dir = Vector2.RIGHT
	elif random_dir == 2:
		adjust_position(Vector2.DOWN)
		current_dir = Vector2.DOWN
	elif random_dir == 3:
		adjust_position(Vector2.LEFT)
		current_dir = Vector2.LEFT
	else:
		adjust_position(Vector2.UP)
		current_dir = Vector2.DOWN

func collision_action(info:KinematicCollision2D):
	if $Timer.is_stopped():
		change_direction()

func cooled_down():
	is_on_cooldown = false

func get_hit() -> void:
	if is_instance_valid(shot_bullet):
		shot_bullet.queue_free()
	if gives_power_up:
		power_up_manager.add_power_up()
		gives_power_up = false
		body_animator.stop()
	emit_signal("dying")
	HighScore.add_to_score(100)
	explode()
	
