extends BaseLevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_bricks(1, 1, Vector2(150,100), 110, 30)
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)


func generate_bricks(max_rows: int, max_columns: int, starting_position: Vector2, spacing_x: int, spacing_y: int) -> void:
	var brick_count: int = 0
	var brick_spawn = Marker2D.new()
	var animation_track = GameManager.BRICK_ANIMATION_TRACKS.pick_random()
	GameManager.call_add_child(brick_spawn)
	brick_spawn.position = starting_position
	
	for row in max_rows:
		for column in max_columns:
			GameManager.create_static(row, brick_spawn.position, animation_track)
			brick_count += 1
			brick_spawn.position.x += spacing_x
		brick_spawn.position.x = starting_position.x
		brick_spawn.position.y += spacing_y
	brick_spawn.queue_free()
	set_total_bricks(brick_count)
