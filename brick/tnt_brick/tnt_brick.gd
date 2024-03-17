extends BaseBrick
 

func _ready() -> void:
	scale_factor = Vector2(2, 0.75)
	super._ready()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BALL):
		GameManager.create_explosion(global_position)
		GameManager.tnt_destroyed.emit()
		super.destroy()
