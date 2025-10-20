extends ProgressBar

var loaded_data = SaveLoad.load_game()
var player_stats = {
					"hunger": value
				}

func _ready():
		var timer = $Timer 
		timer.connect("timeout", _on_timer_timeout)
		max_value = 100.0
		value = loaded_data.get("hunger", 100)

func _on_timer_timeout():
		if value > 0:
				value -= 1.0
		if value <= 0:
			if $Timer.is_stopped():
				return
			$Timer.stop()
			
			print("Oops! player died from starving. Resetting hunger to 100.")
			
			player_stats.set("hunger", 100)
			SaveLoad.save_game(player_stats)
			value = 100.0 
			$Timer.start()
