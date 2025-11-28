extends Label

@onready var objective_anim = $ObjectiveTextAnimation
@onready var objective_label_timer = $ObjectiveLabelTimer

func _ready() -> void:
	objective_label_timer.start()
	print("Objective label timer: Started")
		
func _on_objective_label_timer_timeout() -> void:
	if GlobalData.config.get("user_opened_once") and GlobalData.config.get("is_new_game"):
		print("im on objective labe and user is : ", GlobalData.config.get("user_opened_once"))
		
		GlobalData.update_config_data("is_new_game", false)
		objective_anim.play("show_objective")
		objective_label_timer.stop()
