extends StaticBody2D
class_name BaseBrick

@export var scale_factor: Vector2 = Vector2.ZERO
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



func _on_area_2d_body_entered(body):
	pass # Replace with function body.
