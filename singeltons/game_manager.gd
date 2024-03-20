extends Node

# Power Up Signals
signal paddle_grow
signal paddle_shrink
signal multiball
signal on_zero_ball
signal paddle_shoot

# Brick Signals
signal brick_damage
signal brick_destroyed
signal obstacle_destroyed
signal tnt_destroyed


# Ball Signals
signal ball_destroyed

# Game Singals
signal game_over


# Groups
const GROUP_BALL: String = "ball"
const GROUP_PADDLE: String = "paddle"
const GROUP_POWER_UP: String = "power_up"
const GROUP_BRICK: String = "brick"
const GROUP_PROJECTILE: String = "projectile"

# Collection of all GUI Objects
enum GUI{
	SCORE_STACKING,
}


# All GUI Packed Scenes
var GUI_SCENE: Dictionary = {
	GUI.SCORE_STACKING : preload("res://GUI/score_stacking/score_stacking_label.tscn"),
}


# Collection of all Sprite Objects
enum SPRITES {
	BALL,
	STATICBRICK,
	OBSTACLE,
	TNTBRICK,
	REGENBRICK,
	INVISIBLEBRICK,
	EXPLOSION,
	PADDLE,
	PADDLE_GROW,
	PADDLE_SHRINK,
	MULTIBALL,
	PADDLE_SHOOT,
	PROJECTILE,
}


# A collection of Power Up Sprite Objects
var POWER_UPS: Array[SPRITES] = [SPRITES.PADDLE_GROW, SPRITES.PADDLE_SHRINK, SPRITES.MULTIBALL, SPRITES.PADDLE_SHOOT]
var BRICKS: Array[SPRITES] = [SPRITES.STATICBRICK, SPRITES.TNTBRICK, SPRITES.REGENBRICK, SPRITES.INVISIBLEBRICK] 
var BRICK_ANIMATION_TRACKS: Array[StringName] = ["default", "glow", "neon", "winter", "snow"]


# All Sprite Packed Scenes
var SPRITE_SCENE: Dictionary = {
	SPRITES.BALL : preload("res://ball/ball_characterbody.tscn"),
	SPRITES.STATICBRICK : preload("res://brick/static_brick/static_brick.tscn"),
	SPRITES.OBSTACLE : preload("res://obstacle/obstacle_static.tscn"),
	SPRITES.TNTBRICK : preload("res://brick/tnt_brick/tnt_brick.tscn"),
	SPRITES.REGENBRICK : preload("res://brick/regen_brick/regen_brick.tscn"),
	SPRITES.INVISIBLEBRICK : preload("res://brick/invisible_brick/invisible_brick.tscn"),
	SPRITES.EXPLOSION : preload("res://explosive/explosion.tscn"),
	SPRITES.PADDLE : preload("res://paddle/paddle_static.tscn"),
	SPRITES.PADDLE_GROW : preload("res://power_up/power_up_grow/power_up_grow.tscn"),
	SPRITES.PADDLE_SHRINK : preload("res://power_up/power_up_shrink/power_up_shrink.tscn"),
	SPRITES.MULTIBALL : preload("res://power_up/power_up_multiball/power_up_multiball.tscn"),
	SPRITES.PADDLE_SHOOT : preload("res://power_up/power_up_shoot/power_up_shoot.tscn"),
	SPRITES.PROJECTILE : preload("res://projectile/projectile.tscn"),
}


var total_ball_count: int = 0
var total_score: int = 0


func get_total_ball_count() -> int:
	return total_ball_count


func set_total_ball_count(value: int) -> void:
	# print(total_ball_count)
	total_ball_count = value


func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)


func create_sprite(start_position: Vector2, key: SPRITES) -> void:
	var new_sprite = SPRITE_SCENE[key].instantiate()
	new_sprite.global_position = start_position
	call_add_child(new_sprite)


func create_stacking_label(start_position: Vector2, offset_x: float, offest_y: float, value: int) -> void:
	var new_stacking_label = GUI_SCENE[GUI.SCORE_STACKING].instantiate()
	new_stacking_label.global_position = Vector2(start_position.x + offset_x, start_position.y + offest_y)
	new_stacking_label.set_score_settings(value)
	call_add_child(new_stacking_label)


func create_ball(start_position: Vector2) -> void:
	set_total_ball_count(get_total_ball_count()+1)
	create_sprite(start_position, SPRITES.BALL)


func create_power_up(start_position: Vector2) -> void:
	create_sprite(start_position, POWER_UPS.pick_random())


func create_brick(_health: int, _position: Vector2, key: SPRITES, _animation_track: StringName) -> void:
	var brick_sprite = SPRITE_SCENE[key].instantiate()
	call_add_child(brick_sprite)
	brick_sprite.position = _position
	brick_sprite.health = _health
	# I don't like this type of calculation, it relies on the scene 
	# too much and specific insight into the animation track
	brick_sprite.animated_sprite_2d.animation = _animation_track
	brick_sprite.frame_count = (
		brick_sprite.animated_sprite_2d.get_sprite_frames().get_frame_count(_animation_track)-1
		)
	if _health > brick_sprite.frame_count:
		brick_sprite.health = brick_sprite.frame_count
	if _health < 0:
		_health = 0

func create_static(_health: int, start_position: Vector2, _animation_track: StringName) -> void:
	create_brick(_health, start_position, BRICKS[0], _animation_track)


func create_obstacle(start_position: Vector2) -> void:
	create_sprite(start_position, SPRITES.OBSTACLE)


func create_tnt(_health: int, start_position: Vector2) -> void:
	create_brick(_health, start_position, BRICKS[1], BRICK_ANIMATION_TRACKS[0])


func create_regen(_health: int, start_position: Vector2) -> void:
	create_brick(_health, start_position, BRICKS[2], BRICK_ANIMATION_TRACKS[0])


func create_invisible(_health: int, start_position: Vector2) -> void:
	create_brick(_health, start_position, BRICKS[3], BRICK_ANIMATION_TRACKS[0])


func create_explosion(start_position: Vector2) -> void:
	create_sprite(start_position, SPRITES.EXPLOSION)
