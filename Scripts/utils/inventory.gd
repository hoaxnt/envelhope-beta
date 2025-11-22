extends Control

@onready var item_list: ItemList = Hud.get_node("Control4/Panel/VBoxContainer/Panel/ItemList")

const ITEM_ICONS = {
		"Axe": preload("res://assets/island/tools/axe.png"),
		"Log": preload("res://assets/island/objects/log.png"),
}
func _ready():
		if InventoryManager:
				InventoryManager.inventory_changed.connect(_update_item_list)
				item_list.item_selected.connect(_on_item_list_selected)
		_update_item_list()

func _update_item_list():
		item_list.clear()
		for item_name in InventoryManager.inventory:
				var quantity = InventoryManager.inventory[item_name]
				var display_text = item_name
				
				if quantity > 1:
						display_text = "%s (x%d)" % [item_name, quantity]
			
				var icon = ITEM_ICONS.get(item_name) 
				
				item_list.add_item(display_text, icon, true)
				var index = item_list.get_item_count() - 1
				item_list.set_item_metadata(index, item_name)


func _on_item_list_selected(index: int):
		var item_name = item_list.get_item_metadata(index)
		
		InventoryManager.select_item(item_name)
