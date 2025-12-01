extends Label

@onready var objective_label_timer = $ObjectiveLabelTimer
@onready var hunger_timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")

func _ready() -> void:
	objective_label_timer.start()
