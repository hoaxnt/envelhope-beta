extends Node

@onready var dialogue_box = Hud.get_node("DialogueBox")
@onready var dialogue_box_name = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Name")
@onready var dialogue_box_message = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Message")
@onready var ISLAND_NPC = SaveLoad.load_game(SaveLoad.ISLAND_NPC_PATH)
@onready var boat = get_node("/root/Chapter1/Boat")

var diver_name
var diver_message

signal dialogue_finished

const REQUIRED_WOOD = 3
const WOOD_ITEM_NAME = "Log"

func _ready() -> void:
	if boat:
		print(boat.name)

func handle_npc_interaction(npc_id: String) -> void:
	
	match npc_id:
		"diver":
			ISLAND_NPC = SaveLoad.load_game(SaveLoad.ISLAND_NPC_PATH)
			
			if ISLAND_NPC["diver_objective"] == "completed":
				dialogue_box.start_dialogue("diver_gather_woods_completed", 1, false, "none")
			else:
				if ISLAND_NPC["current_objective"] == "none":
					dialogue_box.start_dialogue("diver", 4, true, "gather_woods")
				else:
					dialogue_box.start_dialogue("diver_gather_woods", 1, false, "gather_woods")
					var wood_count = InventoryManager.inventory.get(WOOD_ITEM_NAME, 0)
					print("wood count ", wood_count)
					
					if wood_count >= REQUIRED_WOOD:
						print("NICE WELL DONE!")
						if boat:
							boat.show()
						dialogue_box.start_dialogue("diver_gather_woods_completed", 1, false, "none")
						InventoryManager.remove_item(WOOD_ITEM_NAME, REQUIRED_WOOD)
						ISLAND_NPC["current_objective"] = "none"
						ISLAND_NPC["diver_objective"] = "completed"
						SaveLoad.save_game(ISLAND_NPC, SaveLoad.ISLAND_NPC_PATH)
					else:
						dialogue_box.start_dialogue("diver_gather_woods", 1, false, "gather_woods")
						print("Comeback if you're done")
					
					
				
	
					#
					#
				#else:
					## D. Show the "come back when you're done" dialogue (e.g., dialogue ID 1)
					#dialogue_box.start_dialogue("diver_gather_woods", 1)
					#print("Comeback if you're done. Need %d more wood." % (REQUIRED_WOOD - wood_count))
			#
			## If you have a completed state:
			#elif ISLAND_NPC["current_objective"] == "completed_gather_woods":
				## Show a post-mission dialogue
				#dialogue_box.start_dialogue("diver_post_mission", 1)
	#
		"balancer":
			dialogue_box.start_dialogue("balancer", 3)
			
			#get_tree().current_scene.call_deferred("queue_free")
			#get_tree().call_deferred("change_scene_to_file", "res://scenes/minigames/island/bfs_minigame.tscn")
		"harvester":
			dialogue_box.start_dialogue("harvester", 2)
			
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
