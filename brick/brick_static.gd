extends StaticBody2D

@export var animated_sprite_2d: AnimatedSprite2D
@export var health: int = 0
@export var frame_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# frame_count = animated_sprite_2d.get_sprite_frames().get_frame_count("default")-1
	# print(frame_count)
	animated_sprite_2d.set_frame(health)
	scale.x = 2
	scale.y = 0.75


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BALL):
		# print(health)
		health-=1
		if health < 0:
			if randf() > 0.5:
				GameManager.create_power_up(global_position)
			queue_free()
			return
		animated_sprite_2d.set_frame(health)
