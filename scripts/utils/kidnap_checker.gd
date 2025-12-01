extends Area2D

func _on_body_entered(body: Node2D) -> void:
	
	var inventory_data =  SaveLoad.load_game(SaveLoad.INVENTORY_PATH)
	
	if body.is_in_group("player"):
		#fortest
		
		if int(inventory_data["Log"]) >= 1 and GlobalData.npc_data.get("current_objective") == "gather_woods":
			print("Log: ", inventory_data["Log"], " Current Objective: ", GlobalData.npc_data.get("current_objective"))
			
			GlobalData.inventory.set("Log", 0)
			GlobalData.npc_data.set("current_objective", "none")
			GlobalData.npc_data.set("diver_objective", "completed")
			GlobalData.update_npc_data("diver_objective", "completed")
			
			
			Hud.hide()
			Transition.transition_to_scene("res://scenes/stories/kidnap_story.tscn")
