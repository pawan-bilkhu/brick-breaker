extends BaseLevel

var obstalce_grid = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_bricks(12, 15, Vector2(62.5,75), 82.5, 30)
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)


func generate_bricks(max_rows: int, max_columns: int, starting_position: Vector2, spacing_x: float, spacing_y: float) -> void:
	var brick_count: int = 0
	var brick_spawn = Marker2D.new()
	var animation_track = GameManager.BRICK_ANIMATION_TRACKS.pick_random()
	GameManager.call_add_child(brick_spawn)
	brick_spawn.position = starting_position
	for row in max_rows:
		for column in max_columns:
			if column == 0 or row == 0 or column == (max_columns-1) or (row == (max_rows-1) and column < (max_columns-3)):
				GameManager.create_obstacle(brick_spawn.position)
			else:
				GameManager.create_static(max_rows - row - 2, brick_spawn.position, animation_track)
			brick_count += 1
			brick_spawn.position.x += spacing_x
		brick_spawn.position.x = starting_position.x
		brick_spawn.position.y += spacing_y
	brick_spawn.queue_free()
	set_total_bricks(brick_count)
