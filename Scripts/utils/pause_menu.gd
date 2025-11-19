extends Control

@onready var canvas_layer : CanvasLayer
var pause_menu_scene = preload("res://scenes/utils/pause_menu.tscn")
var pause_menu_instance = null

func _ready() -> void:
	canvas_layer = get_parent()

func _on_resume_button_pressed() -> void:
	canvas_layer.hide()
	_unpause_game()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://scenes/utils/main_menu.tscn")
	get_tree().current_scene.call_deferred("queue_free")
	canvas_layer.hide()

func _pause_game() -> void:
		if get_tree().paused: return
		get_tree().paused = true
		pause_menu_instance = pause_menu_scene.instantiate()
		add_child(pause_menu_instance)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unpause_game() -> void:
	get_tree().paused = false

func _on_help_button_pressed() -> void:
	Tutorial.show()
	canvas_layer.hide()
	_unpause_game()
