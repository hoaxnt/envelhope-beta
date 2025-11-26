extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.hide()
