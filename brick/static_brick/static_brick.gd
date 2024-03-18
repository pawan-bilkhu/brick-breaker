extends BaseBrick


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# frame_count = animated_sprite_2d.get_sprite_frames().get_frame_count("default")-1
	# print(frame_count)
	animated_sprite_2d.set_frame(health)
	scale_factor = Vector2(2, 0.75)
	super._ready()


# Collision with ball
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BALL):
		# print(health)
		health-=1
		super.on_brick_damage()
		animated_sprite_2d.set_frame(health)
