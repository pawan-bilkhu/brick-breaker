extends BaseBrick


@export var countdown_time: float = 3
@export var max_health: int = 0
@onready var regen_timer: Timer = $RegenTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_health = health
	animated_sprite_2d.set_frame(health)
	scale_factor = Vector2(1.5, 0.75)
	super._ready()


func start_countdown() -> void:
	regen_timer.start(countdown_time)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BALL):
		# print(health)
		health-=1
		super.on_brick_damage()
		animated_sprite_2d.set_frame(health)
		start_countdown()


func _on_regen_timer_timeout() -> void:
	if health >= max_health:
		return
	health += 1
	animated_sprite_2d.set_frame(health)
	start_countdown()
