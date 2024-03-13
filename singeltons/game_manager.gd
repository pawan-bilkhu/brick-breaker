extends Node

# Power Up Signals
signal paddle_grow
signal paddle_shrink
signal multiball
signal on_zero_ball


# Ball Signal
signal ball_destroyed


# Groups
const GROUP_BALL: String = "ball"
const GROUP_PADDLE_GROW: String = "paddle_grow"
const GROUP_PADDLE: String = "paddle"


# Collection of all Sprite Objects
enum SPRITES {
	BALL,
	BRICK,
	PADDLE,
	PADDLE_GROW,
	PADDLE_SHRINK,
	MULTIBALL
}

# A collection of Power Up Sprite Objects
var POWER_UPS: Array[SPRITES] = [SPRITES.PADDLE_GROW, SPRITES.PADDLE_SHRINK, SPRITES.MULTIBALL]

# All Sprite Packed Scenes
var SIMPLE_SCENE: Dictionary = {
	SPRITES.BALL : preload("res://ball/ball_characterbody.tscn"),
	SPRITES.BRICK : preload("res://brick/brick_static.tscn"),
	SPRITES.PADDLE : preload("res://paddle/paddle_static.tscn"),
	SPRITES.PADDLE_GROW : preload("res://power_up/power_up_grow/power_up_grow.tscn"),
	SPRITES.PADDLE_SHRINK : preload("res://power_up/power_up_shrink/power_up_shrink.tscn"),
	SPRITES.MULTIBALL : preload("res://power_up/power_up_multiball/power_up_multiball.tscn"),
}


var total_ball_count: int = 0


func get_total_ball_count() -> int:
	return total_ball_count


func set_total_ball_count(value: int) -> void:
	# print(total_ball_count)
	total_ball_count = value


func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)


func create_object(start_position: Vector2, key: SPRITES) -> void:
	var new_object = SIMPLE_SCENE[key].instantiate()
	new_object.global_position = start_position
	call_add_child(new_object)


func create_ball(start_position: Vector2) -> void:
	set_total_ball_count(get_total_ball_count()+1)
	create_object(start_position, SPRITES.BALL)


func create_power_up(start_position: Vector2) -> void:
	create_object(start_position, POWER_UPS.pick_random())


func create_bricks(max_rows: int, max_columns: int, starting_position: Vector2, spacing_x: int, spacing_y: int):
	var brick_spawn = Marker2D.new()
	call_add_child(brick_spawn)
	brick_spawn.position = starting_position
	for row in max_rows:
		for column in max_columns:
			var brick_sprite = SIMPLE_SCENE[SPRITES.BRICK].instantiate()
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
