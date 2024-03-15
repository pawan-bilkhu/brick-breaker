extends Node2D

@onready var ball_spawn: Marker2D = $Spawn/BallSpawn
@onready var paddle_spawn: Marker2D = $Spawn/PaddleSpawn

@onready var game_start_timer: Timer = $GameStartTimer
@onready var countdown_label: Label = $Labels/CountdownLabel
@onready var score_label: Label = $Labels/ScoreLabel

@export var countdown_time: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	start_countdown()
	GameManager.set_total_ball_count(0)
	GameManager.ball_destroyed.connect(on_ball_destroyed)
	GameManager.multiball.connect(create_multiple_balls)
	GameManager.create_bricks(10, 10, Vector2(150,100), 110, 30)
	GameManager.create_object(paddle_spawn.position, GameManager.SPRITES.PADDLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown_label.text = "%1.00f " % game_start_timer.time_left


func create_multiple_balls() -> void:
	for index in randi_range(1,5):
		create_ball()


func create_ball() -> void:
	if GameManager.get_total_ball_count() == 0:
		GameManager.create_ball(ball_spawn.position)
	else:
		GameManager.create_ball(Vector2(randf_range(200, 1000),ball_spawn.position.y))

func on_ball_destroyed() -> void:
	if GameManager.get_total_ball_count() > 0:
		return
	GameManager.on_zero_ball.emit()
	start_countdown()


func _on_game_start_timer_timeout():
	create_ball()
	countdown_label.hide()


func start_countdown() -> void:
	game_start_timer.start(countdown_time)
	countdown_label.show()
