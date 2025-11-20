extends Node

@onready var dialogue_box = Hud.get_node("DialogueBox")
@onready var dialogue_box_name = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Name")
@onready var dialogue_box_message = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Message")
@onready var ISLAND_NPC = SaveLoad.load_game(SaveLoad.ISLAND_NPC_PATH)
var diver_name
var diver_message

signal dialogue_finished
	
func handle_npc_interaction(npc_id: String) -> void:
	
	match npc_id:
		"diver":
			#diver_name = ISLAND_NPC["diver"]["name"]
			#diver_message = ISLAND_NPC["diver"]["dialogue"]["1"]
			#
			#dialogue_box_name.text = diver_name
			#dialogue_box_message.text = diver_message
			dialogue_box.show()
			
			var high_scores = [6, 3, 5, 4, 2, 7, 1]
			print(bubble_sort(high_scores))
			
		"balancer":
			get_tree().current_scene.call_deferred("queue_free")
			get_tree().call_deferred("change_scene_to_file", "res://scenes/minigames/island/bfs_minigame.tscn")
		"harvester":
				start_dialogue("harvester", "Knowledge is power.")
		_:
				start_dialogue(npc_id, "Hmm... I have nothing to say right now.")
	_on_dialogue_system_closed() 

func _on_dialogue_system_closed() -> void:
		dialogue_finished.emit()
		
func start_dialogue(character_name: String, text: String) -> void:
	
		print("%s : %s" % [character_name, text])

#-- Sorting Algorithm --
func bubble_sort(arr: Array) -> Array:
	var n = arr.size()
	for i in range(n):
		var swapped = false
		for j in range(0, n - i - 1):
			if arr[j] > arr[j + 1]:
				var temp = arr[j]
				arr[j] = arr[j + 1]
				arr[j + 1] = temp
				swapped = true
		if not swapped:
			break
	return arr
