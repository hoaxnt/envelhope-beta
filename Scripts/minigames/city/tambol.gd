extends Node2D
@onready var instructions_panel = $CanvasLayer/Instructions
@onready var anim = $CanvasLayer/AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		print("action")

func _on_start_button_pressed() -> void:
	instructions_panel.hide()
	anim.play("countdown")
