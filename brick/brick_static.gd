extends StaticBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@export var health: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# health = animated_sprite_2d.get_sprite_frames().get_frame_count("default")-1
	animated_sprite_2d.set_frame(health)
	scale.x = 2
	scale.y = 0.75


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BALL):
		print(health)
		health-=1
		if health < 0:
			queue_free()
			return
		animated_sprite_2d.set_frame(health)
