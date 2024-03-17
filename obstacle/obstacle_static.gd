extends BaseBrick


func _ready() -> void:
	scale_factor = Vector2(2, 0.5)
	super._ready()


func destroy() -> void:
	GameManager.obstacle_destroyed.emit()
	super.destroy()


