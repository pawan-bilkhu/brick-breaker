extends BaseBrick


@export var animated_sprite_2d: AnimatedSprite2D
@export var health: int = 0
@export var frame_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# frame_count = animated_sprite_2d.get_sprite_frames().get_frame_count("default")-1
	# print(frame_count)
	animated_sprite_2d.set_frame(health)
	scale_factor = Vector2(2, 0.75)
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func on_health_zero():
	if not is_dead and health >=0:
		GameManager.brick_damage.emit()
		animated_sprite_2d.set_frame(health)
		return
	is_dead = true
	GameManager.brick_destroyed.emit()
	GameManager.create_power_up(global_position)
	queue_free()

# Collision with ball
func _on_area_2d_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BALL):
		# print(health)
		health-=1
		on_health_zero()
