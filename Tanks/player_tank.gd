extends Tank
class_name PlayerTank

export(PackedScene) var heavy_bullet
var tank_level:int = 1
export(Array) var barrels
onready var inputTimer = $InputTimer
onready var tank_barrel:Sprite = $Body/Barrel
onready var shield:CPUParticles2D = $Shield

func _ready():
	velocity = Vector2.UP
	rotate_the_tank()
	shield.emitting = true

func tank_control(delta) -> Vector2:
	var direction:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("move_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
	adjust_position(direction)
	return direction * speed

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		is_shooting = true

func get_tank_level() -> int:
	return tank_level

func set_tank_level(level:int) ->void:
	if level == 2:
		bullet_speed_multiplier = 3
		tank_barrel.texture = barrels[0]
	elif level == 3:
		tank_barrel.texture = barrels[1]
		bullet = heavy_bullet
	else:
		print("not implemented yet")
	tank_level = level

func get_hit() -> void:
	if shield.is_emitting():
		return
	explode()


func explode() -> void:
	PlayerLives.remove_lives(1)
	queue_free()

