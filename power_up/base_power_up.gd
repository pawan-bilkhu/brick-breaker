extends StaticBody2D
class_name BasePowerUp

@export var speed: float = 300.0
@export var is_dead: bool = false
@onready var sprite_2d = %Sprite2D


func _ready():
	pass

func _physics_process(delta):
	global_position.y += speed*delta 
	
func power_ability() -> void:
	pass

func destory() -> void:
	if is_dead:
		return
	is_dead = true
	set_physics_process(false)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	# print("I have been destroyed off screen")
	destory()
