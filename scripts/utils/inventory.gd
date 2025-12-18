extends Control

@onready var item_list: ItemList = get_node_or_null("%ItemList")
@onready var hotbar_container: HBoxContainer = get_node_or_null("%HBoxContainer")
@onready var PLAYER_DATA: Dictionary = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)

const ITEM_ICONS = {
		"Axe": preload("res://assets/island/tools/axe.png"),
		"Log": preload("res://assets/island/objects/log.png"),
		"Banana": preload("res://assets/city/plaza/banana.png"),
		"Water": preload("res://assets/city/plaza/water.png"),
		"Chips": preload("res://assets/city/plaza/chips.png"),
}
func _ready():
	if is_instance_valid(Hud):
		item_list = Hud.get_node_or_null("InventoryPanel/Panel/VBoxContainer/Panel/ItemList")
		hotbar_container = Hud.get_node_or_null("HBoxContainer")
		
	if InventoryManager and is_instance_valid(item_list):
		InventoryManager.inventory_changed.connect(_update_item_list)
		_update_item_list()
	
func _update_item_list():
	if !is_instance_valid(item_list):
		return
		
	item_list.clear()
	
	if InventoryManager:
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
	GlobalData.player_data.set("equipped_tool", item_name)
	
func _on_unequip_button_pressed() -> void:
	if PLAYER_DATA.has("equipped_tool"):
		InventoryManager.select_item(PLAYER_DATA["equipped_tool"])
		PLAYER_DATA["equipped_tool"] = ""
		SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)
