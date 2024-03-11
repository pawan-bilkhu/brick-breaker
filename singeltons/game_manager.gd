extends Node

signal paddle_grow
signal paddle_shrink
signal multi_ball




const GROUP_BALL: String = "ball"
const GROUP_PADDLE_GROW: String = "paddle_grow"

enum OBJECTS {
	BALL,
	BRICK,
	PADDLE,
	PADDLE_GROW,
	
}

var SIMPLE_SCENE: Dictionary = {
	OBJECTS.BALL : preload("res://ball/ball_characterbody.tscn"),
	OBJECTS.BRICK : preload("res://brick/brick_static.tscn"),
	OBJECTS.PADDLE : preload("res://paddle/paddle_static.tscn"),
	OBJECTS.PADDLE_GROW : preload("res://power_up/grow_power_up/paddle_grow_power_up.tscn"),
}

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)

func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_object(start_position: Vector2, key: OBJECTS) -> void:
	var new_object = SIMPLE_SCENE[key].instantiate()
	new_object.global_position = start_position
	call_add_child(new_object)

func create_bricks(row: int, column: int, starting_position: Vector2, spacing_x: int, spacing_y: int):
	var brick_spawn = Marker2D.new()
	call_add_child(brick_spawn)
	brick_spawn.position = starting_position
	for n in row:
		for m in column:
			var brick_sprite = SIMPLE_SCENE[OBJECTS.BRICK].instantiate()
			call_add_child(brick_sprite)
			brick_sprite.position = brick_spawn.position
			brick_sprite.health = n
			brick_spawn.position.x += spacing_x
		brick_spawn.position.x = starting_position.x
		brick_spawn.position.y += spacing_y
