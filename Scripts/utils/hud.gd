extends CanvasLayer

var load_hud = preload("res://scenes/utils/hud.tscn")
var hud = null

func toggle_hud() -> void:
	hud = load_hud.instantiate()
	get_tree().root.add_child(hud)
	print("Child added")
	
func _on_bag_button_pressed() -> void:
	print("Bag")


func _on_view_quest_button_pressed() -> void:
	print("Quest View")
