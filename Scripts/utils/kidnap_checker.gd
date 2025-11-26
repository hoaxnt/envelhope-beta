extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
	var INVENTORY = SaveLoad.load_game(SaveLoad.INVENTORY_PATH)
	NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
	if body.is_in_group("player"):
		if INVENTORY["Log"] >= 1 and NPC_DATA["current_objective"] == "gather_woods":
			
			NPC_DATA["current_objective"] = "none"
			NPC_DATA["diver_objective"] = "completed"
			SaveLoad.save_game(NPC_DATA, SaveLoad.NPC_DATA_PATH)
			Hud.hide()
			Transition.transition_to_scene("res://scenes/stories/kidnap_story.tscn")
		else:
			print("kulang pa")
