extends Label

@onready var objective_anim = $ObjectiveTextAnimation
@onready var timer = $Timer
@onready var sfx = StreamAudio.get_node("Sfx")

func _on_timer_timeout() -> void:
	#fortest
	
	#if CONFIG.get("user_opened_once") == true:
	if GlobalData.config.get("user_opened_once") == true:
		#sfx.stream = StreamAudio.typing
		#sfx.play()
		timer.stop()
