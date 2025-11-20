extends Label

@onready var objective_anim = $ObjectiveTextAnimation
@onready var timer = $Timer

func _on_timer_timeout() -> void:
	var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
	if CONFIG.get("user_opened_once") == true:
		objective_anim.play("show_objective")
		timer.stop()
