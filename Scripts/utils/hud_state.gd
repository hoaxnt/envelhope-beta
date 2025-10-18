extends Node2D

var bag_button = "$Control3/MarginContainer/HBoxContainer/VBoxContainer/BagButton"
var load_hud = preload("res://scenes/utils/hud.tscn")
var hud = null

func toggle_hud() -> void:
	hud = load_hud.instantiate()
	get_tree().root.add_child(hud)
	
func _on_bag_button_pressed() -> void:
	print("Bag")
