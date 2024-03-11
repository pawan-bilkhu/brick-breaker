extends CharacterBody2D

@export var speed: float = 400
@export var MAX_SPEED: float = 800
@export var acceleration: float = 1.02
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = randf_range(200, speed) * float((-1)**randi()%2)
	velocity.x = randf_range(200, speed) * float((-1)**randi()%2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	
	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	if velocity.length() >= MAX_SPEED:
		return
	velocity = velocity * acceleration
