extends Node

func _ready() -> void:
	get_child(3).visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_child(2).visible = true
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_child(2).visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		get_child(3).visible = true
	if event.is_action_pressed("w") or event.is_action_pressed("a") or event.is_action_pressed("s") or event.is_action_pressed("d"):
		get_child(3).visible = false
		
func _on_item_1_button_pressed() -> void:
	var current_envelopes = GlobalData.get_player_data_value("envelopes")
	if current_envelopes < 100:
		print("Not enough envelopes")
		return
		
	print("Item1 bought")
