extends StaticBody2D

const screen_width_max: float = 1280
const screen_width_min: float = 0

@export var speed: float = 400
@export var sprite_width: float = 0 
@export var sprite_scale_x: float = 0

@onready var sprite_2d: Sprite2D = $Sprite2D 

func _ready():
	sprite_width = sprite_2d.get_rect().size.x
	set_scale_x(sprite_scale_x)
	GameManager.paddle_grow.connect(on_paddle_grow)
	GameManager.paddle_shrink.connect(on_paddle_shrink)

func _physics_process(delta):
	
	if Input.is_action_pressed("move_right") and (global_position.x + (sprite_width*scale.x/2))< screen_width_max:
		global_position.x += speed*delta
	elif Input.is_action_pressed("move_left") and (global_position.x - (sprite_width*scale.x/2)) > screen_width_min:
		global_position.x -= speed*delta
		
	# print(global_position.x + (sprite_width/2))

func set_scale_x(value: float) -> void:
	# print("Before width: %f" % sprite_width)
	# print("Global Position: (%f, %f) " % [global_position.x, global_position.y])
	# print("Relative Position: (%f, %f)" % [position.x, position.y])
	scale.x = value
	# print("After width: %f" % (sprite_width*scale.x))

func on_paddle_grow() -> void:
	if scale.x < 10:
		set_scale_x(scale.x + 0.25)

func on_paddle_shrink() -> void:
	if scale.x > 0.25:
		set_scale_x(scale.x - 0.25)
	
func _on_area_2d_body_entered(body):
	pass
