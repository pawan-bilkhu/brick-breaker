extends CharacterBody2D

@export var speed: float = 200
@export var scale_x: float = 0
@export var scale_y: float = 0
@export var MAX_SPEED: float = 800
@export var acceleration: float = 1.02
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = randf_range(speed, 2*speed) * float((-1)**randi()%2)
	velocity.x = randf_range(speed, 2*speed) * float((-1)**randi()%2)
	scale = Vector2(scale_x, scale_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	
	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	if velocity.length() >= MAX_SPEED:
		return
	velocity = velocity * acceleration


func _on_visible_on_screen_notifier_2d_screen_exited():
	GameManager.set_total_ball_count(GameManager.get_total_ball_count()-1)
	GameManager.ball_destroyed.emit()
	queue_free()
	# print("The ball has been destroyed off screen")
