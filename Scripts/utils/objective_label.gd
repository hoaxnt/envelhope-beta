extends Label

@onready var objective_label_timer = $ObjectiveLabelTimer
@onready var hunger_timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")

func _ready() -> void:
	objective_label_timer.start()
	print("Objective label timer: Started")
		
#func _on_objective_label_timer_timeout() -> void:
	##if GlobalData.config.get("user_opened_once") and GlobalData.config.get("is_new_game"):
	#if GlobalData.config.get("is_new_game"):
		#
		#objective_label_timer.stop()
		#objective_anim.play("show_objective")
		
		#hunger_timer.start()
		
