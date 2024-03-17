extends Label

@export var lifespan: float = 0.5
@export var speed: float = 40

@onready var lifespan_timer: Timer = $LifespanTimer


func _ready() -> void:
	start_countdown(lifespan)


func _physics_process(delta: float) -> void:
	position.y+= speed*delta


func set_score_settings(score: int) -> void:
	var font_size: int = 20
	var polarity = ""
	label_settings.font_color = Color.RED
	if score > 0:
		font_size = 40
		polarity = "+"
		label_settings.font_color = Color.GREEN
	label_settings.font_size = font_size
	text = polarity + "%d" % score


func start_countdown(time: int) -> void:
	lifespan_timer.start(time)
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "self_modulate", Color.TRANSPARENT, lifespan)


func _on_lifespan_timeout() -> void:
	queue_free()
