extends Control

@onready var day_progress_bar = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/DayProgressBar
@onready var timer = $Timer

var day_target_value: float = 0.0 
const TWEEN_DURATION = 0.5

func _ready():
	day_target_value = day_progress_bar.value
	if !timer.is_connected("timeout", _on_timer_timeout):
		timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	day_target_value += 1.0
	day_target_value = clamp(day_target_value, 0.0, day_progress_bar.max_value)
	
	var tween = create_tween()
	tween.tween_property(day_progress_bar, "value", day_target_value, TWEEN_DURATION)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
