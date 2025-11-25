extends Area2D

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
