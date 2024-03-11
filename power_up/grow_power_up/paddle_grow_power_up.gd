extends BasePowerUp

@export var scale_x: float = 0.5
@export var scale_y: float = 0.5


func _ready():
	scale.x = scale_x
	scale.y = scale_y

func power_ability() -> void:
	GameManager.paddle_grow.emit()
	destroy()

func destroy() -> void:
	super.destory()

func _on_visible_on_screen_notifier_2d_screen_exited():
	super._on_visible_on_screen_notifier_2d_screen_exited()
