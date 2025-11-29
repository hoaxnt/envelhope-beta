extends Node

@onready var dialogue_box = Hud.get_node("DialogueBox")
@onready var dialogue_box_name = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Name")
@onready var dialogue_box_message = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Message")
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)

var diver_name
var diver_message

signal dialogue_finished

const REQUIRED_WOOD = 15 #fortest
const WOOD_ITEM_NAME = "log"

func handle_npc_interaction(npc_id: String) -> void:
	match npc_id:
		"diver":
			NPC_DATA = GlobalData.npc_data
			if NPC_DATA["current_objective"] == "none":
				dialogue_box.start_dialogue("diver", 4, true, "gather_woods")
			else:
				dialogue_box.start_dialogue("diver_gather_woods", 1, false, "gather_woods")
				var wood_count = InventoryManager.inventory.get(WOOD_ITEM_NAME, 0)
				print("wood count ", wood_count)
				
				if wood_count >= REQUIRED_WOOD:
					
					InventoryManager.remove_item(WOOD_ITEM_NAME, REQUIRED_WOOD)
					NPC_DATA["current_objective"] = "none"
					NPC_DATA["diver_objective"] = "completed"
					SaveLoad.save_game(NPC_DATA, SaveLoad.NPC_DATA_PATH)
				else:
					dialogue_box.start_dialogue("diver_gather_woods", 1, false, "gather_woods")
				
		"harvester":
			dialogue_box.start_dialogue("harvester", 4, false, "none")
			
		"balancer":
			dialogue_box.start_dialogue("balancer", 3, false, "none")
		_:
			pass
	_on_dialogue_system_closed() 

func _on_dialogue_system_closed() -> void:
		dialogue_finished.emit()

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
