extends Node

var inventory: Dictionary = {}

signal inventory_changed
signal tool_selected(item_name: String)
var selected_item_name: String = ""

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

func remove_item(item_name: String, quantity: int = 1) -> bool:
	if !inventory.has(item_name):
		print("Cannot remove %s. Not found in inventory." % item_name)
		return false
			
	if inventory[item_name] >= quantity:
		inventory[item_name] -= quantity
		
		if inventory[item_name] <= 0:
			inventory.erase(item_name)
				
		print("Removed %s %s." % [quantity, item_name])
		inventory_changed.emit()
		return true
	else:
		print("Not enough %s to remove." % item_name)
		return false
		
func select_item(item_name: String):
	if item_name == selected_item_name:
		deselect_item()
		return
		
	if inventory.has(item_name):
		selected_item_name = item_name
		tool_selected.emit(item_name)
		print("Manager: Equipped: %s" % selected_item_name)

	elif item_name == "":
		deselect_item()
		
	else:
		print("Error: Tried to select item (%s) not in inventory." % item_name)
		
func deselect_item():
	if selected_item_name != "":
		selected_item_name = ""
		tool_selected.emit("")
		print("Manager: Item deselected/unequipped.")
