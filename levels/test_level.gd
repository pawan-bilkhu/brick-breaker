extends Node2D

@onready var ball_spawn: Node = $Spawn/BallSpawn
@onready var paddle_spawn: Node = $Spawn/PaddleSpawn

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.create_object(ball_spawn.position, GameManager.OBJECTS.BALL)
	GameManager.create_bricks(7, 10, Vector2(150,100), 110, 30)
	GameManager.create_object(paddle_spawn.position, GameManager.OBJECTS.PADDLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
