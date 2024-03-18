extends BaseBrick

@export var countdown_time: float = 0.8

@onready var visibility_timer = $VisibilityTimer

func _ready() -> void:
	frame_count = animated_sprite_2d.get_sprite_frames().get_frame_count("default")-1
	health = frame_count
	animated_sprite_2d.visible = false
	animated_sprite_2d.set_frame(health)
	scale_factor = Vector2(2, 0.75)
	super._ready()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BALL):
		# print(health)
		health-=1
		animated_sprite_2d.visible = true
		super.on_brick_damage()
		visibility_timer.start(countdown_time)
		animated_sprite_2d.set_frame(health)


func _on_visibility_timer_timeout() -> void:
	animated_sprite_2d.visible = false
