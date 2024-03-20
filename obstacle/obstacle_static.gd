extends BaseBrick


func _ready() -> void:
	scale_factor = Vector2(1.5, 0.5)
	super._ready()


func destroy() -> void:
	GameManager.obstacle_destroyed.emit()
	super.destroy()


