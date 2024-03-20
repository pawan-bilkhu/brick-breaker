extends CharacterBody2D

@export var speed: float = 200
@export var scale_x: float = 0
@export var scale_y: float = 0
@export var MAX_SPEED: float = 900
@export var acceleration: float = 1.02
@export var audio_stream_player_2d: AudioStreamPlayer2D

var is_dead: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.game_over.connect(destroy)
	velocity.y = speed * float((-1)**randi()%2)
	velocity.x = speed * float((-1)**randi()%2)
	scale = Vector2(scale_x, scale_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	var collision = move_and_collide(velocity*delta)

	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	SoundManager.play_clip(audio_stream_player_2d, SoundManager.SOUND.PLOP)
	if velocity.length() >= MAX_SPEED:
		return
	velocity = velocity * acceleration

func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	GameManager.ball_destroyed.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	GameManager.set_total_ball_count(GameManager.get_total_ball_count()-1)
	destroy()
	# print("The ball has been destroyed off screen")
