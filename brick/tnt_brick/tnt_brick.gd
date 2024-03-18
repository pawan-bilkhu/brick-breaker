extends BaseBrick

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D 

func _ready() -> void:
	cpu_particles_2d.emitting = true
	scale_factor = Vector2(2, 0.75)
	super._ready()

func destroy() -> void:
	GameManager.create_explosion(global_position)
	GameManager.tnt_destroyed.emit()
	super.destroy()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BALL):
		destroy()
