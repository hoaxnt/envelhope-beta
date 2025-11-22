# HotbarSlot.gd
extends Control
#REMOVE UNIMPORTANT CODE AND FIX THE HOTBAR FUNCTIONALITY OR MAYBE THINK OF ANOTHER IDEA
## --- References ---
@onready var icon_display: TextureRect = Hud.get_node("Control6/Icon")
@onready var label_display: Label = $Label #Hud.get_node("Control6/Label")
@onready var highlight: ColorRect = $ColorRect #Hud.get_node("Control6/ColorRect")
@onready var button_area: Button = $SlotButton #Hud.get_node("Control6/SlotButton")

var slot_index: int = -1 # Will be set by the InventoryUI manager
var item_name: String = ""

func _ready() -> void:
	pass

# Called by the InventoryUI script to update visuals
func update_slot_visuals(name: String, quantity: int, icon_texture: Texture2D):
	item_name = name
	
	# 1. Update Icon
	#icon_display.texture = icon_texture
	
	# 2. Update Quantity
	if quantity > 1:
			label_display.text = str(quantity)
	else:
			label_display.text = ""
			pass

# Called by InventoryUI to show/hide the equipped state
func set_selected(is_selected: bool):
	highlight.visible = is_selected

# Called when the button is pressed
func _on_InteractionArea_pressed():
	# Signal back to the InventoryUI manager with our index
	if InventoryManager:
		if item_name != "":
			# Select this item (equips the tool)
			InventoryManager.select_item(item_name)
		else:
			# Deselect any currently equipped tool
			InventoryManager.select_item("")
