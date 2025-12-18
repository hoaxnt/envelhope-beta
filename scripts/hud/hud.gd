extends CanvasLayer

@onready var sfx = StreamAudio.get_node("Sfx")
@onready var inventory_panel = Hud.get_node("InventoryPanel")
@onready var objective_label_anim = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var action_button = $ActionButton
signal action_button_pressed_signal 

var is_action_pressed = false 

func _ready() -> void:
	hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if GlobalData.player_data.get("equipped_tool") == "Chips":
			GlobalData.player_data.set("equipped_tool", "")
			InventoryManager.remove_item("Chips")
			action_button.hide()
		elif GlobalData.player_data.get("equipped_tool") == "Banana":
			GlobalData.player_data.set("equipped_tool", "")
			InventoryManager.remove_item("Banana")
			action_button.hide()
		elif GlobalData.player_data.get("equipped_tool") == "Water":
			GlobalData.player_data.set("equipped_tool", "")
			InventoryManager.remove_item("Water")
			action_button.hide()
		else:
			sfx.stream = StreamAudio.chop
			sfx.play()
		action_button_pressed_signal.emit()

func _on_action_button_pressed() -> void:
	if GlobalData.player_data.get("equipped_tool") == "Chips":
		GlobalData.player_data.set("equipped_tool", "")
		InventoryManager.remove_item("Chips")
		action_button.hide()
	elif GlobalData.player_data.get("equipped_tool") == "Banana":
		GlobalData.player_data.set("equipped_tool", "")
		InventoryManager.remove_item("Banana")
		action_button.hide()
	elif GlobalData.player_data.get("equipped_tool") == "Water":
		GlobalData.player_data.set("equipped_tool", "")
		InventoryManager.remove_item("Water")
		action_button.hide()
	else:
		sfx.stream = StreamAudio.chop
		sfx.play()
	action_button_pressed_signal.emit()
	
func _on_bag_button_pressed() -> void:
	if inventory_panel:
		inventory_panel.visible = not inventory_panel.visible
		
func _on_view_quest_button_pressed() -> void:
	if objective_label_anim:
		objective_label_anim.play("show_objective")
