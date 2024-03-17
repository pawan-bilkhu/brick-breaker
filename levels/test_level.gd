extends Node2D

@onready var ball_spawn: Marker2D = $Spawn/BallSpawn
@onready var paddle_spawn: Marker2D = $Spawn/PaddleSpawn

@onready var game_start_timer: Timer = $GameStartTimer
@onready var countdown_label: Label = $Labels/CountdownLabel
@onready var score_label: Label = $Labels/ScoreLabel

@export var countdown_time: int = 0
var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize Score and Ball count
	set_score(0)
	GameManager.set_total_ball_count(0)
	
	# Create Sprites
	GameManager.generate_bricks(10, 10, Vector2(150,100), 110, 30)
	GameManager.create_sprite(paddle_spawn.position, GameManager.SPRITES.PADDLE)
	
	# Connect Signals
	GameManager.brick_damage.connect(change_score.bind(15))
	GameManager.tnt_destroyed.connect(change_score.bind(5))
	GameManager.obstacle_destroyed.connect(change_score.bind(10))
	GameManager.brick_destroyed.connect(change_score.bind(30))
	GameManager.ball_destroyed.connect(change_score.bind(-1))
	GameManager.ball_destroyed.connect(on_ball_destroyed)
	GameManager.multiball.connect(create_multiple_balls)
	
	# Start Game
	start_countdown()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	countdown_label.text = "%1.00f " % game_start_timer.time_left


func set_score(value: int )->void:
	score = value


func get_score()->int:
	return score


func change_score(value: int) -> void:
	set_score(get_score() + value)
	GameManager.create_stacking_label(Vector2(score_label.global_position.x, score_label.global_position.y), 70, 5, value)
	display_score(get_score())


func create_multiple_balls() -> void:
	for index in randi_range(2,5):
		create_ball()


func display_score(value: int)->void:
	score_label.text = "%d" % value


func create_ball() -> void:
	if GameManager.get_total_ball_count() == 0:
		GameManager.create_ball(ball_spawn.position)
	else:
		GameManager.create_ball(Vector2(randf_range(400, 800), ball_spawn.position.y))


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
