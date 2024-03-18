extends StaticBody2D
class_name BaseBrick

@export var scale_factor: Vector2 = Vector2.ONE
@export var animated_sprite_2d: AnimatedSprite2D
@export var frame_count: int = 0
@export var health: int = 0
var is_dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	apply_scale(scale_factor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	queue_free()


func on_brick_damage() -> void:
	if health < 0:
		GameManager.brick_destroyed.emit()
		GameManager.create_power_up(global_position)
		destroy()
		return
	GameManager.brick_damage.emit()


func _on_area_2d_body_entered(body: Node2D):
	pass # Replace with function body.
