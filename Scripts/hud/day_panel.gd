extends Control

@onready var day_progress_bar = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/DayProgressBar
@onready var day_timer = $DayTimer
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH) 
@onready var player = get_node("/root/Chapter2/Player")

var day_target_value: float = 0.0 
const TWEEN_DURATION = 0.5

func _ready():
	day_target_value = day_progress_bar.value
	if !day_timer.is_connected("timeout", _on_timer_timeout):
		day_timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout() -> void:
	NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
	
	if NPC_DATA["day"] == 4 and day_target_value >= 180:
		day_timer.stop()
		
	if day_target_value >= 180 and NPC_DATA["day"] < 4:
		Hud.hide()
		day_timer.stop()
		Transition.transition_to_scene("res://scenes/stories/sleep_story.tscn")
		day_target_value = 0
		return
	
	day_target_value += 50.0 #fortest
	day_target_value = clamp(day_target_value, 0.0, day_progress_bar.max_value)

	var tween = create_tween()
	tween.tween_property(day_progress_bar, "value", day_target_value, TWEEN_DURATION)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
