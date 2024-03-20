extends StaticBody2D


const screen_width_max: float = 1280
const screen_width_min: float = 0
const min_scale_x: float = 0.25
const max_scale_x: float = 10


@export var speed: float = 500.0
@export var sprite_width: float = 0.0
@export var sprite_scale_x: float = 0.0
@export var can_shoot: bool = false
@export var time: float = 3.0
@export var scale_factor: float = 0.25


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shoot_power_timer: Timer = $ShootPowerTimer
@onready var projectile_spawn: Marker2D = $ProjectileSpawn


func _ready():
	sprite_width = sprite_2d.get_rect().size.x
	set_scale_x(sprite_scale_x)
	GameManager.paddle_grow.connect(on_paddle_grow)
	GameManager.paddle_shrink.connect(on_paddle_shrink)
	GameManager.paddle_shoot.connect(shooting_enabled)


func _physics_process(delta):
	
	if Input.is_action_pressed("move_right") and (global_position.x + (sprite_width*scale.x/2))< screen_width_max:
		global_position.x += speed*delta
	elif Input.is_action_pressed("move_left") and (global_position.x - (sprite_width*scale.x/2)) > screen_width_min:
		global_position.x -= speed*delta


	if Input.is_action_just_pressed("shoot") and can_shoot:
		GameManager.create_sprite(projectile_spawn.global_position, GameManager.SPRITES.PROJECTILE)
	# print(global_position.x + (sprite_width/2))


func set_scale_x(value: float) -> void:
	# print("Before width: %f" % sprite_width)
	# print("Global Position: (%f, %f) " % [global_position.x, global_position.y])
	# print("Relative Position: (%f, %f)" % [position.x, position.y])
	scale.x = value
	# print("After width: %f" % (sprite_width*scale.x))


func on_paddle_grow() -> void:
	if scale.x < max_scale_x:
		var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN)
		tween.tween_method(set_scale_x, scale.x, scale.x + scale_factor, 1)


func on_paddle_shrink() -> void:
	if scale.x > min_scale_x:
		var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN)
		tween.tween_method(set_scale_x, scale.x, scale.x - scale_factor, 1)


func shooting_enabled() -> void:
	shoot_power_timer.start(time)
	can_shoot = true


func shooting_disabled() -> void:
	can_shoot = false


func _on_area_2d_body_entered(_body):
	pass


func _on_shoot_power_timer_timeout():
	shooting_disabled()
