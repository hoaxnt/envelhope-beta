extends ProgressBar

@onready var hunger_timer = $HungerTimer

const DEATH_SCENE_PATH = "res://scenes/game_over/death_scene.tscn"

func _ready():
	max_value = 100.0

	value = GlobalData.get_player_data_value("hunger")
	
	if value > 0:
		hunger_timer.start()
	
	GlobalData.player_data_updated.connect(_on_player_data_updated)

func _on_timer_timeout():
	var current_hunger = value 
	
	if current_hunger > 0:
		var new_hunger = current_hunger - 5
		
		if new_hunger < 0:
			new_hunger = 0 
			
		GlobalData.update_player_data("hunger", new_hunger)
		value = new_hunger
		
	if value <= 0:
		hunger_timer.stop() 
		
		GlobalData.handle_hunger_reset_city()
		await Transition.transition_to_scene("res://scenes/stories/hospitalized_story.tscn")
		
func _on_player_data_updated(key: String, new_value):
	if key == "hunger":
		self.value = new_value
		if new_value > 0 and not hunger_timer.is_stopped():
			hunger_timer.start()
