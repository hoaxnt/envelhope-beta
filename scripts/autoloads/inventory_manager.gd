extends Node

var inventory: Dictionary = {}
var selected_item_name: String = ""
@onready var INVENTORY: Dictionary = SaveLoad.load_game(SaveLoad.INVENTORY_PATH)
@onready var action_button = Hud.get_node("ActionButton")

signal inventory_changed
signal tool_selected(item_name: String)

const MAX_SLOTS = 5

func add_item(item_name: String, quantity: int = 1) -> bool:
	if inventory.has(item_name):
		inventory[item_name] += quantity
		
		if item_name == "Log":
			var current_logs = INVENTORY.get("Log", 0)
			current_logs += quantity
			INVENTORY["Log"] = current_logs
			SaveLoad.save_game(INVENTORY, SaveLoad.INVENTORY_PATH)
			
		inventory_changed.emit()
		return true

	if inventory.size() < MAX_SLOTS:
		inventory[item_name] = quantity
		
		if item_name == "Log":
			INVENTORY["Log"] = quantity
			SaveLoad.save_game(INVENTORY, SaveLoad.INVENTORY_PATH)
			
		inventory_changed.emit()
		return true

	print("Inventory is full. Cannot add %s." % item_name)
	return false

func remove_item(item_name: String, quantity: int = 1) -> bool:
	if !inventory.has(item_name):
		print("Cannot remove %s. Not found in inventory." % item_name)
		return false

	if inventory[item_name] >= quantity:
		inventory[item_name] -= quantity

		if item_name == "Log":
			var current_logs = INVENTORY.get("Log", 0)
			current_logs -= quantity
			if current_logs < 0:
				current_logs = 0 # Prevent negative values in save data
			INVENTORY["Log"] = current_logs
			SaveLoad.save_game(INVENTORY, SaveLoad.INVENTORY_PATH)
			
		if inventory[item_name] <= 0:
			inventory.erase(item_name)

		inventory_changed.emit()
		return true
	else:
		print("Not enough %s to remove." % item_name)
		return false

func select_item(item_name: String):
	#if item_name == selected_item_name:
		#deselect_item()
		#return
	
	if item_name == "Chips" or item_name == "Water" or item_name == "Banana":
		action_button.text = "Use [C]"
		action_button.show()
	else:
		action_button.text = ""
		action_button.hide()
		
	if inventory.has(item_name):
		selected_item_name = item_name
		tool_selected.emit(item_name)

	#elif item_name.is_empty():
		#deselect_item()
		
func deselect_item():
	if !selected_item_name.is_empty():
		selected_item_name = ""
		tool_selected.emit("")

func is_axe_selected() -> bool:
	return selected_item_name == "Axe"
