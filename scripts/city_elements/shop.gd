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
		
func _on_item_1_button_pressed() -> void:
	print("Item1")
