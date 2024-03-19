extends Sprite2D

@export var speed: float = 0
@export var is_dead: bool = false

func _ready():
	pass


func _physics_process(delta):
	position.y -= speed*delta


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	set_physics_process(false)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	# print("projectile has been destroyed")
	destroy()


func _on_area_2d_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BRICK):
		if body.has_method("on_brick_damage"):
			body.health -= 2
			body.on_brick_damage()
		else:
			body.destroy()
		destroy()
