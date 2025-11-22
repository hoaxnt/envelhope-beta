extends Control

@onready var item_list: ItemList = Hud.get_node("Control4/Panel/VBoxContainer/Panel/ItemList")

const ITEM_ICONS = {
		"Axe": preload("res://assets/island/tools/axe.png"),
		"Log": preload("res://assets/island/objects/log.png"),
}
func _ready():
		# Connect to the global InventoryManager's signal
		if InventoryManager:
				InventoryManager.inventory_changed.connect(_update_item_list)
				item_list.item_selected.connect(_on_item_list_selected)
		
		# Initial load of the inventory when the scene starts
		_update_item_list()

## --- Core Update Function ---

func _update_item_list():
		# 1. Clear the existing list items
		item_list.clear()
		
		# 2. Iterate through the inventory dictionary (Name: Quantity)
		for item_name in InventoryManager.inventory:
				var quantity = InventoryManager.inventory[item_name]
				var display_text = item_name
				
				# If stackable, show quantity
				if quantity > 1:
						display_text = "%s (x%d)" % [item_name, quantity]
				
				# 3. Add the item to the ItemList node
				var icon = ITEM_ICONS.get(item_name) 
				
				# item_list.add_item(text, icon, selectable)
				item_list.add_item(display_text, icon, true)
				
				# Optional: Store the raw item_name in metadata for later use
				var index = item_list.get_item_count() - 1
				item_list.set_item_metadata(index, item_name)


## --- Selection/Equipping Logic ---

func _on_item_list_selected(index: int):
		# Get the raw item name you stored in the metadata
		var item_name = item_list.get_item_metadata(index)
		
		# Tell the InventoryManager to select this item (which then tells the Player to equip it)
		InventoryManager.select_item(item_name)
