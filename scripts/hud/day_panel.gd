extends Control

@onready var day_progress_bar = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/DayProgressBar
@onready var day_timer = $DayTimer
@onready var day_label = $MarginContainer/HBoxContainer/VBoxContainer/DayLabel

var day_current_time: float = 0.0 

const TWEEN_DURATION = 0.5

func _ready():
	day_current_time = day_progress_bar.value
	day_label.text = "Day %s" % str(int(GlobalData.npc_data.get("day", 0)))
	
func _on_day_timer_timeout() -> void:
	day_label.text = "Day %s" % str(int(GlobalData.npc_data.get("day", 0)))
	
	if GlobalData.npc_data.get("day") == 4 and day_current_time >= 180:
		day_timer.stop()
	
	if day_current_time >= 180 and GlobalData.npc_data.get("day") < 4:
		Hud.hide()
		day_timer.stop()
		day_current_time = 0
		
		Transition.transition_to_scene("res://scenes/stories/sleep_story.tscn")
		return
		
	day_current_time += 1.5                        #fortest
	day_current_time = clamp(day_current_time, 0.0, day_progress_bar.max_value)

	var tween = create_tween()
	tween.tween_property(day_progress_bar, "value", day_current_time, TWEEN_DURATION)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
