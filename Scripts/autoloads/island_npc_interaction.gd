extends Node

@export var dialog_box : Control

signal dialogue_finished
		
func handle_npc_interaction(npc_id: String) -> void:
		match npc_id:
				"diver":
					
					var high_scores = [6, 3, 5, 4,2,7,1]
					print(bubble_sort(high_scores))
					
					#start_dialogue("diver", "Welcome to my shop!")
				"balancer":
					get_tree().current_scene.call_deferred("queue_free")
					get_tree().call_deferred("change_scene_to_file", "res://scenes/minigames/island/bfs_minigame.tscn")
					
						#start_dialogue("balancer", "Hello, adventurer.")
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
