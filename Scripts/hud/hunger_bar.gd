extends ProgressBar

@onready var hunger_timer = $HungerTimer

func _ready():
	max_value = 100.0
	value = float(GlobalData.get_player_data_value("hunger"))
	hunger_timer.start()
		
	GlobalData.player_data_updated.connect(_on_player_data_updated)	

func _on_player_data_updated(key: String, new_value):
	if key == "hunger":	
		self.value = new_value

func _on_timer_timeout():
	if value > 0:
		value -= 1
		
		GlobalData.update_player_data("hunger", value)
		
		var player_position = GlobalData.player_data.get("position")
		GlobalData.update_player_data("position", player_position)
		
	if value <= 0:
		hunger_timer.stop()
		
		
		GlobalData.handle_hunger_reset_city()

		value = 100.0
		hunger_timer.start()
