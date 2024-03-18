extends Area2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


var is_dead: bool = false

func _ready() -> void:
	pass


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	destroy()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BRICK):
		if body.has_method("on_brick_damage"):
			body.health -= 2
			body.on_brick_damage()
		else:
			body.destroy()
