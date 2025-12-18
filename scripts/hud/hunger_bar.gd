extends ProgressBar

@onready var hunger_timer = $HungerTimer
var equipped_tool : String
var HUNGER_DECREMENT = 0.05 #fortest
var HUNGER_GAIN = 10

func _ready():
	show_percentage = false
	max_value = 100.0 #fortest
	GlobalData.player_data_updated.connect(_on_player_data_updated)
	
	if GlobalData.player_data:
		value = GlobalData.player_data.get("hunger")

func _unhandled_input(event: InputEvent) -> void:
	equipped_tool = Hud.equipped_tool
	if event.is_action_pressed("use"):
		print("HUNGER PUMP")
		if equipped_tool == "Chips":
			GlobalData.player_data["hunger"] += HUNGER_GAIN
			GlobalData.player_data["hunger"] = min(GlobalData.player_data["hunger"], 100.0)
			SaveLoad.save_game(GlobalData.player_data, SaveLoad.PLAYER_DATA_PATH)
			
func _on_hunger_timer_timeout() -> void:
	var current_hunger = GlobalData.get_player_data_value("hunger")
	if current_hunger > 0: #fortest
		if GlobalState.HUNGER_MODE == "idle":
			HUNGER_DECREMENT = 0.1
		elif GlobalState.HUNGER_MODE == "walk":
			HUNGER_DECREMENT = 0.5
		elif GlobalState.HUNGER_MODE == "run":
			HUNGER_DECREMENT = 1
		
		var new_hunger = current_hunger - HUNGER_DECREMENT
		
		if new_hunger <= 30:
			var fill_sb = get_theme_stylebox("fill")
			if fill_sb is StyleBoxFlat:
				var new_fill = fill_sb.duplicate()
				new_fill.bg_color = Color(0.956, 0.049, 0.231, 1.0)
				add_theme_stylebox_override("fill", new_fill)
		
		if new_hunger <= 0:
			new_hunger = 0
			hunger_timer.stop()
		GlobalData.player_data.set("hunger", new_hunger)
	
		value = new_hunger
		
		if value <= 0:
			if GlobalData.npc_data.get("diver_objective") == "completed":
				
				Hud.hide()
				Transition.transition_to_scene("res://scenes/stories/hospitalized_story.tscn")
				GlobalData.handle_hunger_reset_city()
				value = GlobalData.get_player_data_value("hunger")
			else:
				
				Hud.hide()
				Transition.transition_to_scene("res://scenes/stories/death_island.tscn")
				GlobalData.handle_hunger_reset_island()
				value = GlobalData.get_player_data_value("hunger")
					
					
func _on_player_data_updated(key: String, new_value):
	if key == "hunger":
		self.value = new_value
