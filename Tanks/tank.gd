extends KinematicBody2D
class_name Tank


export(PackedScene) var bullet
export(PackedScene) var explosion
export var bullet_speed_multiplier:float = 2
export var speed:int = 100

var can_shoot:bool = true
var velocity:Vector2 = Vector2.ZERO
var is_shooting:bool = false
var is_not_moving = true
var shot_bullet:Bullet = null


onready var tween:Tween = $Tween
onready var raycastUp:RayCast2D = $RayCastUp
onready var raycastDown:RayCast2D = $RayCastDown
onready var raycastRight:RayCast2D = $RayCastRight
onready var raycastLeft:RayCast2D = $RayCastLeft
onready var body:Sprite = $Body
onready var shotExplosion = $Body/Barrel/ShotExplosion

func _physics_process(delta):
	if is_not_moving:
		velocity = tank_control(delta)
		move_the_tank(delta)
	rotate_the_tank()
	if is_shooting:
		shoot()
	pass

func collision_action(info):
	pass

func shoot():
	if can_shoot:
		var new_bullet:Bullet = bullet.instance()
		new_bullet.velocity = get_tank_direction() * speed * bullet_speed_multiplier
		new_bullet.position = position + get_tank_direction() * 64
		new_bullet.rotation_degrees = body.rotation_degrees - 180
		new_bullet.from_tank = self
		shot_bullet = new_bullet
		get_parent().add_child(new_bullet)
		shotExplosion.restart()
		shotExplosion.emitting = true
		can_shoot = false
		is_shooting = false

func tank_control(delta:float) -> Vector2:
	return Vector2.ZERO

func rotate_the_tank():
	if velocity.normalized() == Vector2.RIGHT:
		body.rotation_degrees = 270
	elif velocity.normalized() == Vector2.UP:
		body.rotation_degrees  = 180
	elif velocity.normalized() == Vector2.DOWN:
		body.rotation_degrees  = 0
	elif velocity.normalized() == Vector2.LEFT:
		body.rotation_degrees  = 90

func get_tank_direction() -> Vector2:
	if body.rotation_degrees == 180:
		return Vector2.UP
	elif body.rotation_degrees == 270:
		return Vector2.RIGHT
	elif body.rotation_degrees == 0:
		return Vector2.DOWN
	else:
		return Vector2.LEFT

func move_the_tank(delta:float):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		collision_action(collision_info)

func check_for_collisions_in_direction(direction:Vector2) -> bool:
	var detection:bool = false
	if direction == Vector2.UP:
		detection = raycastUp.is_colliding()
	elif direction == Vector2.DOWN:
		detection = raycastDown.is_colliding()
	elif direction == Vector2.RIGHT:
		detection = raycastRight.is_colliding()
	elif direction == Vector2.LEFT:
		detection = raycastLeft.is_colliding()
	return detection

func movement_completed():
	is_not_moving = true

func adjust_position(direction:Vector2):
	if (direction == Vector2.UP or direction == Vector2.DOWN) and (get_tank_direction() == Vector2.LEFT or get_tank_direction() == Vector2.RIGHT):
		var new_position = Vector2(round(position.x / 64)*64,round(position.y / 64)*64)
		position = new_position
	if (direction == Vector2.LEFT or direction == Vector2.RIGHT) and (get_tank_direction() == Vector2.UP or get_tank_direction() == Vector2.DOWN):
		var new_position = Vector2(round(position.x / 64)*64,round(position.y / 64)*64)
		position = new_position

func get_hit() -> void:
	if is_instance_valid(shot_bullet):
		shot_bullet.queue_free()
	explode()

func explode() -> void:
	var new_explosion:Explosion = explosion.instance()
	new_explosion.position = position
	get_parent().add_child(new_explosion)
	new_explosion.play("explode")
	queue_free()

