extends Node

signal dialogue_finished

func handle_npc_interaction(npc_id: String) -> void:
		match npc_id:
				"shopkeeper_greg":
						start_dialogue("shopkeeper_greg", "Welcome to my shop!")
				"quest_giver_elara":
						start_dialogue("quest_giver_elara", "Hello, adventurer.")
				"statue_of_wisdom":
						start_dialogue("statue_of_wisdom", "Knowledge is power.")
				_:
						start_dialogue(npc_id, "Hmm... I have nothing to say right now.")
						
		_on_dialogue_system_closed() 

func _on_dialogue_system_closed() -> void:
		print("Dialogue system closed. Emitting signal.")
		dialogue_finished.emit()
		
func start_dialogue(character_name: String, text: String) -> void:
		print("%s says: %s" % [character_name, text])
		
