extends Panel

@onready var ISLAND_NPC = SaveLoad.load_game(SaveLoad.ISLAND_NPC_PATH)
@onready var dialogue_box = Hud.get_node("DialogueBox")
@onready var next_button = Hud.get_node("DialogueBox/NextButton")
@onready var dialogue_box_name = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Name") as Label
@onready var dialogue_box_message = Hud.get_node("DialogueBox/MarginContainer/VBoxContainer/Message") as Label

var current_npc_key = "diver"
var current_line_index = 0    
var max_line_count = 0        

func _ready() -> void:
	hide()

func start_dialogue(npc_key: String):
	print(ISLAND_NPC[current_npc_key]["dialogue"])
	current_npc_key = npc_key
	current_line_index = 0
	
	var dialogue_dict = ISLAND_NPC[current_npc_key]["dialogue"]
	
	max_line_count = dialogue_dict.length()
	dialogue_box_name.text = ISLAND_NPC[current_npc_key]["name"]
	
	# Show the box and the first line
	dialogue_box.show()
	_update_dialogue_text()
	
func _update_dialogue_text():
	var line_key = str(current_line_index)
	var current_line = ISLAND_NPC[current_npc_key]["dialogue"].get(line_key, "--- Error ---")
	dialogue_box_message.text = current_line

func next_dialogue_line():
	print("Button Clicked. Current line: ", current_line_index, ", Max: ", 5)
	if current_line_index < 5:
		current_line_index += 1
		if current_line_index < 5:
			_update_dialogue_text()
		else:
			close_dialogue()
	else:
		close_dialogue()

# --- Close Function ---
func close_dialogue():
	dialogue_box.hide()
	current_line_index = 0
