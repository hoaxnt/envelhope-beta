extends Node

var inventory: Dictionary = {}
var selected_item_name: String = ""

signal inventory_changed
signal tool_selected(item_name: String)

const MAX_SLOTS = 10

func add_item(item_name: String, quantity: int = 1) -> bool:
	if inventory.has(item_name):
		inventory[item_name] += quantity
		print("Added %s %s. New count: %s" % [quantity, item_name, inventory[item_name]])
		inventory_changed.emit() 
		return true
	
	if inventory.size() < MAX_SLOTS:
		inventory[item_name] = quantity
		print("New item added: %s" % item_name)
		inventory_changed.emit()
		return true
			
	print("Inventory is full. Cannot add %s." % item_name)
	return false

# Function to remove an item (e.g., when crafting or using)
func remove_item(item_name: String, quantity: int = 1) -> bool:
	if !inventory.has(item_name):
		print("Cannot remove %s. Not found in inventory." % item_name)
		return false
			
	if inventory[item_name] >= quantity:
		inventory[item_name] -= quantity
		
		if inventory[item_name] <= 0:
			inventory.erase(item_name)
				
		print("Removed %s %s." % [quantity, item_name])
		inventory_changed.emit() # Notify listeners
		return true
	else:
		print("Not enough %s to remove." % item_name)
		return false

func select_item(item_name: String):
	if inventory.has(item_name):
		selected_item_name = item_name
		tool_selected.emit(item_name)
		print("Selected item: %s" % selected_item_name)
	else:
		selected_item_name = ""
		tool_selected.emit("")
		print("Deselected item.")

func is_axe_selected() -> bool:
	return selected_item_name == "Axe"
