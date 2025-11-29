extends ProgressBar

@onready var hunger_timer = $HungerTimer

const HUNGER_DECREMENT = 1 #fortest

func _ready():
	show_percentage = false
	max_value = 100.0 #fortest
	GlobalData.player_data_updated.connect(_on_player_data_updated)
	
	value = GlobalData.player_data.get("hunger")

func _on_hunger_timer_timeout() -> void:
	var current_hunger = GlobalData.get_player_data_value("hunger")
	
	if current_hunger > 0:
		var new_hunger = current_hunger - HUNGER_DECREMENT
		
		if new_hunger <= 0:
			new_hunger = 0
			hunger_timer.stop()
			
		GlobalData.update_player_data("hunger", new_hunger)
	
		value = new_hunger
		
		if value == 0:
			if GlobalData.npc_data.get("diver_objective") == "completed":
				print("hunger reset city")
				Hud.hide()
				Transition.transition_to_scene("res://scenes/stories/hospitalized_story.tscn")
				GlobalData.handle_hunger_reset_city()
				value = GlobalData.get_player_data_value("hunger")
			else:
				print("hunger reset island")
				Hud.hide()
				Transition.transition_to_scene("res://scenes/stories/death_island.tscn")
				GlobalData.handle_hunger_reset_island()
				value = GlobalData.get_player_data_value("hunger")
					
func _on_player_data_updated(key: String, new_value):
	if key == "hunger":
		self.value = new_value
