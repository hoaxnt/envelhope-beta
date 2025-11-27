extends Area2D

var is_player_near: bool

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near = true
		$Label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near = true
		$Label.hide()
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_near:
		Hud.hide()
		Transition.transition_to_scene("res://scenes/minigames/island/pearl_diving.tscn")
		
