extends CanvasLayer

@onready var sfx = StreamAudio.get_node("Sfx")
@onready var inventory_panel = Hud.get_node("InventoryPanel")
@onready var objective_label_anim = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var action_button = $ActionButton

signal action_button_pressed_signal 
var equipped_tool : String
var is_action_pressed = false 

func _ready() -> void:
	hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		equipped_tool = GlobalData.player_data.get("equipped_tool")
		if equipped_tool == "Chips":
			GlobalData.player_data.set("equipped_tool", "")
			InventoryManager.remove_item(equipped_tool)
			InventoryManager.deselect_item()
			action_button.hide()
			GlobalData.player_data["hunger"] += 0.8 #thungergain
			GlobalData.player_data["hunger"] = min(GlobalData.player_data["hunger"], 100.0)
			SaveLoad.save_game(GlobalData.player_data, SaveLoad.PLAYER_DATA_PATH)
			
		elif equipped_tool == "Water":
			GlobalData.player_data.set("equipped_tool", "")
			InventoryManager.remove_item(equipped_tool)
			InventoryManager.deselect_item()
			action_button.hide()
			GlobalData.player_data["hunger"] += 2 #thungergain
			GlobalData.player_data["hunger"] = min(GlobalData.player_data["hunger"], 100.0)
			SaveLoad.save_game(GlobalData.player_data, SaveLoad.PLAYER_DATA_PATH)
			
		elif equipped_tool == "Banana":
			GlobalData.player_data.set("equipped_tool", "")
			InventoryManager.remove_item(equipped_tool)
			InventoryManager.deselect_item()
			action_button.hide()
			GlobalData.player_data["hunger"] += 5 #thungergain
			GlobalData.player_data["hunger"] = min(GlobalData.player_data["hunger"], 100.0)
			SaveLoad.save_game(GlobalData.player_data, SaveLoad.PLAYER_DATA_PATH)
		else:
			sfx.stream = StreamAudio.chop
			sfx.play()
		action_button_pressed_signal.emit()

func _on_action_button_pressed() -> void:
	equipped_tool = GlobalData.player_data.get("equipped_tool")
	if equipped_tool == "Chips":
		GlobalData.player_data.set("equipped_tool", "")
		InventoryManager.remove_item(equipped_tool)
		InventoryManager.deselect_item()
		action_button.hide()
		GlobalData.player_data["hunger"] += 5 #thungergain
		GlobalData.player_data["hunger"] = min(GlobalData.player_data["hunger"], 100.0)
		SaveLoad.save_game(GlobalData.player_data, SaveLoad.PLAYER_DATA_PATH)
		
	elif equipped_tool == "Water":
		GlobalData.player_data.set("equipped_tool", "")
		InventoryManager.remove_item(equipped_tool)
		InventoryManager.deselect_item()
		action_button.hide()
		GlobalData.player_data["hunger"] += 10 #thungergain
		GlobalData.player_data["hunger"] = min(GlobalData.player_data["hunger"], 100.0)
		SaveLoad.save_game(GlobalData.player_data, SaveLoad.PLAYER_DATA_PATH)
		
	elif equipped_tool == "Banana":
		GlobalData.player_data.set("equipped_tool", "")
		InventoryManager.remove_item(equipped_tool)
		InventoryManager.deselect_item()
		action_button.hide()
		GlobalData.player_data["hunger"] += 15 #thungergain
		GlobalData.player_data["hunger"] = min(GlobalData.player_data["hunger"], 100.0)
		SaveLoad.save_game(GlobalData.player_data, SaveLoad.PLAYER_DATA_PATH)
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
