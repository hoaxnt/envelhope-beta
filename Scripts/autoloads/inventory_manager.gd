extends Node

var inventory: Dictionary = {}
signal inventory_changed

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
				
				# Remove entry completely if quantity drops to 0
				if inventory[item_name] <= 0:
						inventory.erase(item_name)
						
				print("Removed %s %s." % [quantity, item_name])
				inventory_changed.emit() # Notify listeners
				return true
		else:
				print("Not enough %s to remove." % item_name)
				return false

## --- Tool Selection (For your Axe Mechanic) ---

var selected_item_name: String = ""

# Function to change the currently equipped/selected item
func select_item(item_name: String):
		if inventory.has(item_name):
				selected_item_name = item_name
				print("Selected item: %s" % selected_item_name)
		else:
				selected_item_name = ""
				print("Deselected item.")

# Function to check if the axe is currently selected
func is_axe_selected() -> bool:
		return selected_item_name == "Axe"

# (Add more functions here for saving, loading, and equipping)
