extends StaticBody2D

var is_dead: bool = false

func _ready() -> void:
	apply_scale(Vector2(2, 0.5))

func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	GameManager.create_explosion(global_position)
	GameManager.tnt_destroyed.emit()
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BALL):
		destroy()
