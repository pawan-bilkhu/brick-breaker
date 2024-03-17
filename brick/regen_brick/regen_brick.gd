extends BaseBrick

@export var animated_sprite_2d: AnimatedSprite2D
@export var health: int = 0
@export var frame_count: int = 0
@export var countdown_time: float = 5

@onready var regen_timer: Timer = $RegenTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	frame_count = animated_sprite_2d.get_sprite_frames().get_frame_count("default")-1
	animated_sprite_2d.set_frame(health)
	scale_factor = Vector2(2, 0.75)
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_health_zero():
	if is_dead:
		return	
	if health >=0:
		GameManager.brick_damage.emit()
		animated_sprite_2d.set_frame(health)
		regen_timer.start(countdown_time)
		return
	is_dead = true
	GameManager.brick_destroyed.emit()
	GameManager.create_power_up(global_position)
	queue_free()


func start_countdown() -> void:
	regen_timer.stop()
	regen_timer.start(countdown_time)


func _on_area_2d_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BALL):
		# print(health)
		health-=1
		on_health_zero()


func _on_regen_timer_timeout():
	if health >= frame_count:
		return
	health += 1
	animated_sprite_2d.set_frame(health)
