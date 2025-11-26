extends Node2D
@onready var instructions_panel = $CanvasLayer/Instructions

func _on_start_button_pressed() -> void:
	instructions_panel.hide()
