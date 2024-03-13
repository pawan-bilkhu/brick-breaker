extends PowerUpBase

func _on_area_2d_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PADDLE):
		GameManager.multiball.emit()
		super.destroy()
