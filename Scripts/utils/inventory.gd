extends Control

@onready var item_list: ItemList = Hud.get_node("Control4/Panel/VBoxContainer/Panel/ItemList")
@onready var hotbar_container: HBoxContainer = Hud.get_node("HBoxContainer")

const ITEM_ICONS = {
		"Axe": preload("res://assets/island/tools/axe.png"),
		"Log": preload("res://assets/island/objects/log.png"),
}

# The container node in your UI (e.g., HBoxContainer or GridContainer)

const HOTBAR_SLOT_SCENE = preload("res://scenes/hud/hotbar_slot2.tscn")
const HOTBAR_SIZE = 3 # Fixed size for your hotbar

# Storage for the instantiated slot scripts (where we store 'Axe' for slot 1)
var hotbar_slots_data: Array = []

func _ready():
	_initialize_hotbar_slots() # NEW: Setup the hotbar slots initially
		
	if InventoryManager:
		InventoryManager.inventory_changed.connect(_update_all_hotbar_slots)
		# NEW: Listen for the tool selection to update the visual highlight
		InventoryManager.tool_selected.connect(_update_selection_visual)
	_update_all_hotbar_slots()
	
	if InventoryManager:
		InventoryManager.inventory_changed.connect(_update_item_list)
		item_list.item_selected.connect(_on_item_list_selected)
			
	_update_item_list()

func _initialize_hotbar_slots():
	for i in range(HOTBAR_SIZE):
		var slot_instance = HOTBAR_SLOT_SCENE.instantiate()
		hotbar_container.add_child(slot_instance)

		slot_instance.slot_index = i # Give the slot its index

		# Store a dictionary with the necessary data
		hotbar_slots_data.append({
				"item_name": "", # What item is assigned to this slot
				"slot_script": slot_instance # Reference to the instantiated script
		})

# You will modify this function to assign the selected item to a hotbar slot.
func _on_item_list_selected(index: int):
	var item_name = item_list.get_item_metadata(index)

	# 🔴 CORE LOGIC: Assign to the first slot (index 0) if it's the axe
	if item_name == "Axe":
		assign_item_to_hotbar_slot(item_name, 0)
	# You would add logic here to assign items to other slots (1, 2) manually or via drag-and-drop.


func assign_item_to_hotbar_slot(item_name: String, slot_index: int):
	if slot_index < 0 or slot_index >= HOTBAR_SIZE:
		return

	var slot_data = hotbar_slots_data[slot_index]
	slot_data["item_name"] = item_name # Update the data storage

	# Force a visual update of all slots
	_update_all_hotbar_slots() 


	### B. Update Visuals

	# This function updates all hotbar slots based on the current data
func _update_all_hotbar_slots():
	for i in range(HOTBAR_SIZE):
		var slot_data = hotbar_slots_data[i]
		var item_name = slot_data["item_name"]
		var slot_script = slot_data["slot_script"]

		var quantity = InventoryManager.inventory.get(item_name, 0)
		var icon = ITEM_ICONS.get(item_name)

		# Call the update function on the slot's script instance
		slot_script.update_slot_visuals(item_name, quantity, icon)

	# This function visually highlights the currently equipped slot
func _update_selection_visual(selected_item_name: String):
	for i in range(HOTBAR_SIZE):
		var slot_data = hotbar_slots_data[i]
		var slot_script = slot_data["slot_script"]

		var is_selected = slot_data["item_name"] == selected_item_name

		# Turn the highlight on/off
		slot_script.set_selected(is_selected)

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


#func _on_item_list_selected(index: int):
		#var item_name = item_list.get_item_metadata(index)
		#
		#InventoryManager.select_item(item_name)
