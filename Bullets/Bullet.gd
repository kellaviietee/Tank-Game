extends Area2D
class_name Bullet

var from_tank = null
var velocity:Vector2 = Vector2.ZERO
onready var bullet_rotation = $BulletBlue1Outline.rotation_degrees


func _physics_process(delta):
	position += velocity * delta


func bullet_collided(body:Node2D):
	if not is_instance_valid(body):
		return
	if get_tree().get_nodes_in_group("Enemy").has(body) and get_tree().get_nodes_in_group("Enemy").has(from_tank):
		pass
	elif get_tree().get_nodes_in_group("Player").has(body) and get_tree().get_nodes_in_group("Player").has(from_tank):
		pass
	elif get_tree().get_nodes_in_group("Map").has(body) or get_tree().get_nodes_in_group("Iron").has(body):
		free_bullet()
	elif get_tree().get_nodes_in_group("Wood").has(body):
		body.queue_free()
		free_bullet()
	else:
		body_collided_with_tank(body)

func body_collided_with_tank(body):
	if get_tree().get_nodes_in_group("Enemy").has(body):
		body.get_hit()
		free_bullet()
	elif get_tree().get_nodes_in_group("Player").has(body):
		body.get_hit()
		free_bullet()

func free_bullet():
	if is_instance_valid(from_tank):
		from_tank.can_shoot = true
		from_tank.is_shooting = false
	queue_free()
	

func _on_Bullet_area_entered(area):
	if get_tree().get_nodes_in_group("Bullet").has(area):
		area.free_bullet()
		free_bullet()
