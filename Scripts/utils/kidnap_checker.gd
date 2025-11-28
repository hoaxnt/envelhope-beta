extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#fortest
		if GlobalData.inventory.get("Log") >= 1 and GlobalData.npc_data.get("current_objective") == "gather_woods":
			
			GlobalData.update_npc_data("current_objective", "none")
			GlobalData.update_npc_data("diver_objective", "completed")
			
			Hud.hide()
			Transition.transition_to_scene("res://scenes/stories/kidnap_story.tscn")
