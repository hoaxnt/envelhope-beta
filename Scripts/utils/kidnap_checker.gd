extends Area2D

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)

func _on_body_entered(body: Node2D) -> void:
	var INVENTORY = SaveLoad.load_game(SaveLoad.INVENTORY_PATH)
	if body.is_in_group("player"):
		if INVENTORY["log"] >= 1:
			Hud.hide()
			Transition.transition_to_scene("res://scenes/stories/kidnap_story.tscn")
