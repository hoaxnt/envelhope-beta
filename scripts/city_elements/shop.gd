extends Node

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_child(2).visible = true
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_child(2).visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("shop")
		
#		BUG: fix the shop item button size and code 
