extends Node2D

@onready var ball_spawn = $Spawn/BallSpawn
@onready var brick_spawn = $Spawn/BrickSpawn

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.create_object(ball_spawn.position, GameManager.OBJECTS.BALL)
	GameManager.create_bricks(5, 10, Vector2(150,100), 110, 30)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
