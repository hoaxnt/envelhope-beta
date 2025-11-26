extends Area2D

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)

func _on_body_entered(body: Node2D) -> void:
	var INVENTORY = SaveLoad.load_game(SaveLoad.INVENTORY_PATH)
	if body.is_in_group("player"):
		if INVENTORY["log"] >= 1:
			
			NPC_DATA["current_objective"] = "none"
			NPC_DATA["diver_objective"] = "completed"
			SaveLoad.save_game(NPC_DATA, SaveLoad.NPC_DATA_PATH)
			
			Hud.hide()
			Transition.transition_to_scene("res://scenes/stories/kidnap_story.tscn")
