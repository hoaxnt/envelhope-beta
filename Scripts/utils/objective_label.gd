extends Label

@onready var objective_anim = $ObjectiveTextAnimation
@onready var timer = $Timer
@onready var sfx = StreamAudio.get_node("Sfx")

func _on_timer_timeout() -> void:
	var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
	
	if CONFIG.get("user_opened_once") == true:
		#sfx.stream = StreamAudio.typing
		#sfx.play()
		timer.stop()
