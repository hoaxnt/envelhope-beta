extends Panel

@onready var ISLAND_NPC = SaveLoad.load_game(SaveLoad.ISLAND_NPC_PATH)
@onready var dialogue_box = Hud.get_node("DialogueBox")
@onready var next_button = Hud.get_node("DialogueBox/NextButton")
@onready var dialogue_box_name = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Name") as Label
@onready var dialogue_box_message = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Message") as Label

var current_npc_key = null
var current_line_index = 1
var max_line_count = 0        

func _ready() -> void:
	hide()

func start_dialogue(npc_key: String, max_lines: int):
	current_npc_key = npc_key
	current_line_index = 1
	
	dialogue_box_name.text = ISLAND_NPC[current_npc_key]["name"]
	max_line_count = max_lines
	
	dialogue_box.show()
	_update_dialogue_text()
	
func _update_dialogue_text():
	var line_key = str(current_line_index)
	var current_line = ISLAND_NPC[current_npc_key]["dialogue"].get(line_key, "...")
	dialogue_box_message.text = current_line

func next_dialogue_line():
	if current_line_index <= max_line_count:
		current_line_index += 1
		if current_line_index <= max_line_count:
			_update_dialogue_text()
		else:
			close_dialogue()
	else:
		close_dialogue()

# --- Close Function ---
func close_dialogue():
	dialogue_box.hide()
	current_line_index = 0
