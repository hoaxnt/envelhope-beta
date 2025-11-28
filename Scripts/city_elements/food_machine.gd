extends Area2D

var is_player_near_the_machine: bool
const FOOD_COST = 15#fortest
const HUNGER_GAIN = 20.0 #fortest

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near_the_machine = true
		$Label.show()
			
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near_the_machine = false
		$Label.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_near_the_machine:

		var current_envelopes = GlobalData.get_player_data_value("envelopes")
				
		if current_envelopes < FOOD_COST:
			print("Not enough envelope: ", current_envelopes)
			$Label.text = "Not enough Envelope!"
			$Label.modulate = Color(1, 0, 0, 1)
			return
						
		$Label.text = "Buy Food for $15 [E]"
		$Label.modulate = Color(1, 1, 1, 1)
			
		GlobalData.purchase_food(FOOD_COST, HUNGER_GAIN)
		
		var hunger_bar = get_tree().get_first_node_in_group("hunger_bar")
		if hunger_bar:
			hunger_bar.value = GlobalData.get_player_data_value("hunger")
