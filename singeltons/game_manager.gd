extends Node

# Power Up Signals
signal paddle_grow
signal paddle_shrink
signal multi_ball

# Ball Signal
signal ball_destroyed




const GROUP_BALL: String = "ball"
const GROUP_PADDLE_GROW: String = "paddle_grow"
const GROUP_PADDLE: String = "paddle"

enum OBJECTS {
	BALL,
	BRICK,
	PADDLE,
	PADDLE_GROW,
	PADDLE_SHRINK,
}

var POWER_UPS: Array[OBJECTS] = [OBJECTS.PADDLE_GROW, OBJECTS.PADDLE_SHRINK]

var SIMPLE_SCENE: Dictionary = {
	OBJECTS.BALL : preload("res://ball/ball_characterbody.tscn"),
	OBJECTS.BRICK : preload("res://brick/brick_static.tscn"),
	OBJECTS.PADDLE : preload("res://paddle/paddle_static.tscn"),
	OBJECTS.PADDLE_GROW : preload("res://power_up/power_up_grow/power_up_grow.tscn"),
	OBJECTS.PADDLE_SHRINK : preload("res://power_up/power_up_shrink/power_up_shrink.tscn")
}

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)

func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_object(start_position: Vector2, key: OBJECTS) -> void:
	var new_object = SIMPLE_SCENE[key].instantiate()
	new_object.global_position = start_position
	call_add_child(new_object)

func create_ball(starting_position: Vector2) -> void:
	create_object(starting_position, OBJECTS.BALL)

func create_power_up(start_position: Vector2) -> void:
	create_object(start_position, POWER_UPS.pick_random())

func create_bricks(max_rows: int, max_columns: int, starting_position: Vector2, spacing_x: int, spacing_y: int):
	var brick_spawn = Marker2D.new()
	call_add_child(brick_spawn)
	brick_spawn.position = starting_position
	for row in max_rows:
		for column in max_columns:
			var brick_sprite = SIMPLE_SCENE[OBJECTS.BRICK].instantiate()
			call_add_child(brick_sprite)
			brick_sprite.position = brick_spawn.position
			brick_sprite.health = row
			
			# I don't like this type of calculation, it relies on the scene 
			# too much and specific insight into the animation track
			
			brick_sprite.frame_count = ( 
				brick_sprite.animated_sprite_2d.get_sprite_frames().get_frame_count("default")-1 
				)
			if row > brick_sprite.frame_count:
				brick_sprite.health = 0
			brick_spawn.position.x += spacing_x
		brick_spawn.position.x = starting_position.x
		brick_spawn.position.y += spacing_y
	brick_spawn.queue_free()
