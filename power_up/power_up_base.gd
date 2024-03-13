extends Sprite2D
class_name PowerUpBase

@export var max_speed: float = 100
@export var min_speed: float = 200
@export var scale_x: float = 0.5
@export var scale_y: float = 0.5

@export var is_dead: bool = false

var speed: float = 0

func _ready():
	GameManager.on_zero_ball.connect(destroy)
	speed = randf_range(min_speed, max_speed)
	scale.x = scale_x
	scale.y = scale_y

func _physics_process(delta):
	global_position.y += speed*delta 
	
func power_ability() -> void:
	pass

func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	set_physics_process(false)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	# print("I have been destroyed off screen")
	destroy()


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
