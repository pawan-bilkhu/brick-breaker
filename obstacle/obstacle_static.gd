extends StaticBody2D

var is_dead: bool = false

func _ready() -> void:
	apply_scale(Vector2(2, 0.5))


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	GameManager.obstacle_destroyed.emit()
	queue_free()


