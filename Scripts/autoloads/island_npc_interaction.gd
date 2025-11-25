extends Node

@onready var dialogue_box = Hud.get_node("DialogueBox")
@onready var dialogue_box_name = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Name")
@onready var dialogue_box_message = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Message")
@onready var ISLAND_NPC = SaveLoad.load_game(SaveLoad.ISLAND_NPC_PATH)

var diver_name
var diver_message

signal dialogue_finished

const REQUIRED_WOOD = 1 #fortest
const WOOD_ITEM_NAME = "Log"

func _ready() -> void:
	var boat = get_node("/root/Chapter1/Boat")
	if boat:
		print(boat.name)

func handle_npc_interaction(npc_id: String) -> void:
	var boat = get_node("/root/Chapter1/Boat")
	if boat:
		print(boat.name)
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
						if boat:
							print(boat.name)
							boat.show()
						dialogue_box.start_dialogue("diver_gather_woods_completed", 1, false, "none")
						InventoryManager.remove_item(WOOD_ITEM_NAME, REQUIRED_WOOD)
						ISLAND_NPC["current_objective"] = "none"
						ISLAND_NPC["diver_objective"] = "completed"
						SaveLoad.save_game(ISLAND_NPC, SaveLoad.ISLAND_NPC_PATH)
					else:
						dialogue_box.start_dialogue("diver_gather_woods", 1, false, "gather_woods")
						print("Comeback if you're done")
					
		"harvester":
			Hud.hide()
			Transition.transition_to_scene("res://scenes/minigames/island/path_finding/forest_chase.tscn")
			dialogue_box.start_dialogue("harvester", 4, true, "deliver_the_goods")
			
		"balancer":
			dialogue_box.start_dialogue("balancer", 3)
			
			
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
