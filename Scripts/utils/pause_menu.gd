extends Control

@onready var canvas_layer : CanvasLayer
@onready var tutorial = Hud.get_node("Tutorial")
@onready var player_1 = get_node("/root/Chapter1/Player")
@onready var player_2 = get_node("/root/Chapter2/Player")

@onready var hunger_timer : Timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")
@onready var day_timer: Timer = Hud.get_node("DayPanel/DayTimer")


var pause_menu_scene = preload("res://scenes/utils/pause_menu.tscn")
var pause_menu_instance = null

func _ready() -> void:
	canvas_layer = get_parent()

func _on_resume_button_pressed() -> void:
	canvas_layer.hide()
	_unpause_game()

func _pause_game() -> void:
	if get_tree().paused: return
	get_tree().paused = true
	pause_menu_instance = pause_menu_scene.instantiate()
	add_child(pause_menu_instance)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unpause_game() -> void:
	get_tree().paused = false

func _on_help_button_pressed() -> void:
	tutorial.show()
	canvas_layer.hide()
	_unpause_game()

func _on_main_menu_button_pressed() -> void:
	if player_1:
		GlobalData.save_player1_position(player_1.global_position)
	if player_2:
		GlobalData.save_player2_position(player_2.global_position)
		
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://scenes/utils/main_menu.tscn")
	get_tree().current_scene.call_deferred("queue_free")
	Hud.hide()
	canvas_layer.hide()
	
	# Saved shits
	hunger_timer.stop()
	day_timer.stop()
	if player_1:
		GlobalData.save_player1_position(player_1.global_position)
		GlobalData.player_data.set("current_chapter", player_1.get_parent().name)
		print("PARENT: ",player_1.global_position)
	elif player_2:
		GlobalData.save_player2_position(player_2.global_position)
		GlobalData.player_data.set("current_chapter", player_2.get_parent().name)
		print("PARENT: ",player_2.global_position)
	
