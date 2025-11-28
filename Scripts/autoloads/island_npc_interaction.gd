#extends Node
#
#@onready var dialogue_box = Hud.get_node("DialogueBox")
#@onready var dialogue_box_name = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Name")
#@onready var dialogue_box_message = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Message")
#@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
#
#var diver_name
#var diver_message
#
#signal dialogue_finished
#
#const REQUIRED_WOOD = 1
#const WOOD_ITEM_NAME = "log"
#
#func handle_npc_interaction(npc_id: String) -> void:
	#match npc_id:
		#"diver":
			#NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
			#if NPC_DATA["current_objective"] == "none":
				#dialogue_box.start_dialogue("diver", 4, true, "gather_woods")
			#else:
				#dialogue_box.start_dialogue("diver_gather_woods", 1, false, "gather_woods")
				#var wood_count = InventoryManager.inventory.get(WOOD_ITEM_NAME, 0)
				#print("wood count ", wood_count)
				#
				#if wood_count >= REQUIRED_WOOD:
					#
					#InventoryManager.remove_item(WOOD_ITEM_NAME, REQUIRED_WOOD)
					#NPC_DATA["current_objective"] = "none"
					#NPC_DATA["diver_objective"] = "completed"
					#SaveLoad.save_game(NPC_DATA, SaveLoad.NPC_DATA_PATH)
				#else:
					#dialogue_box.start_dialogue("diver_gather_woods", 1, false, "gather_woods")
				#
		#"harvester":
			#dialogue_box.start_dialogue("harvester", 4, false, "none")
			#
		#"balancer":
			#dialogue_box.start_dialogue("balancer", 3, false, "none")
		#_:
			#pass
	#_on_dialogue_system_closed() 
#
#func _on_dialogue_system_closed() -> void:
		#dialogue_finished.emit()
#
##-- Sorting Algorithm --
#func bubble_sort(arr: Array) -> Array:
	#var n = arr.size()
	#for i in range(n):
		#var swapped = false
		#for j in range(0, n - i - 1):
			#if arr[j] > arr[j + 1]:
				#var temp = arr[j]
				#arr[j] = arr[j + 1]
				#arr[j + 1] = temp
				#swapped = true
		#if not swapped:
			#break
	#return arr





















extends Node

# --- Node References (Assuming Hud is an Autoload or accessible via the Root)
# ⚠️ FIX: Use get_node_or_null() for external nodes, or better, pass the nodes 
# via signal/method if the script is not strictly a UI controller.
@onready var hud: CanvasLayer = get_node("/root/Hud") # Assuming Hud is an Autoload/Root
@onready var dialogue_box: Control = hud.get_node_or_null("DialogueBox")
# We don't need to reference individual label children here unless we update them manually.
# dialogue_box_name and dialogue_box_message references removed for simplicity 
# (the DialogueBox script should handle its children).

# ⚠️ FIX: Removed @onready var NPC_DATA = SaveLoad.load_game(...)
# We must rely on the in-memory GlobalData.npc_data.

# --- Data Constants and Variables
signal dialogue_finished

const REQUIRED_WOOD: int = 1
const WOOD_ITEM_NAME: String = "log"

# --- NPC Interaction Logic (Relying on GlobalData)

## 💬 Handles dialogue and quest logic when interacting with an NPC.
func handle_npc_interaction(npc_id: String) -> void:
	if not is_instance_valid(dialogue_box):
		print("ERROR: DialogueBox not found or not ready.")
		return

	# Use the safe getter function from GlobalData (as discussed previously)
	var current_objective: String = GlobalData.get_npc_attribute(
		npc_id, 
		"current_objective", 
		"none" # Default to "none" if the key is missing
	)
	
	match npc_id:
		"diver":
			var wood_count = InventoryManager.inventory.get(WOOD_ITEM_NAME, 0)
			
			if current_objective == "none":
				# Start Quest: Dialogue box sets objective for the player
				dialogue_box.start_dialogue("diver_start_quest", 4, true, "gather_woods") 
				
				# Update GlobalData with the new objective immediately
				GlobalData.update_npc_data(npc_id, "current_objective", "gather_woods")
			
			elif current_objective == "gather_woods":
				if wood_count >= REQUIRED_WOOD:
					# Quest Complete
					InventoryManager.remove_item(WOOD_ITEM_NAME, REQUIRED_WOOD)
					
					# Update GlobalData: clear current objective and mark quest completed
					GlobalData.update_npc_data(npc_id, "current_objective", "none")
					GlobalData.update_npc_data(npc_id, "diver_objective", "completed")
					
					# Success dialogue (Assumed new dialogue ID)
					dialogue_box.start_dialogue("diver_quest_success", 1, false, "none")
				else:
					# Quest Incomplete: Player doesn't have enough wood
					print("Wood count: ", wood_count)
					dialogue_box.start_dialogue("diver_gather_woods_reminder", 1, false, "gather_woods")
				
		"harvester":
			dialogue_box.start_dialogue("harvester_dialogue", 4, false, "none")
			
		"balancer":
			dialogue_box.start_dialogue("balancer_dialogue", 3, false, "none")
			
		_:
			print("No interaction defined for NPC:", npc_id)

	# ⚠️ FIX: This should not be called here. The dialogue system should emit a 
	# signal (e.g., 'dialogue_box_closed') when the user is done reading, 
	# and this script should connect to that signal.
	# _on_dialogue_system_closed() 
	
## 🛑 Called when the dialogue box signals it has finished closing.
func _on_dialogue_system_closed() -> void:
	# This function should be connected to the DialogueBox's own signal (e.g., dialogue_box.dialogue_ended)
	# and then emit the local signal for the rest of the game to use.
	dialogue_finished.emit()

# ----------------------------------------------------------------------------
## 📦 Sorting Algorithm (Modular Function)

## Sorts an array of comparable elements using the Bubble Sort algorithm.
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
