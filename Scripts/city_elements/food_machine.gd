extends Area2D

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
var is_player_near_the_machine: bool

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near_the_machine = true
		$Label.show()
		
		if PLAYER_DATA[""]

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near_the_machine = false
		$Label.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_near_the_machine:
		if PLAYER_DATA["envelopes"] < 15:
			$Label.text = "Not enough Envelope!"
			$Label.modulate = Color(1, 0, 0, 1)
			return
		$Label.text = "Buy Food for $15 [E]"
		$Label.modulate = Color(1, 1, 1, 1)
			
		PLAYER_DATA["envelopes"] -= 15
		SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)
		
