extends ProgressBar

var player_stats = {
	"hunger": 100.0
}

var loaded_data = {}

func _ready():
		loaded_data = SaveLoad.load_game()
		var saved_hunger = loaded_data.get("hunger", 100.0)
		
		max_value = 100.0
		value = saved_hunger
		player_stats["hunger"] = saved_hunger

		var timer = $Timer
		if is_instance_valid(timer):
				timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
		if value > 0:
				value -= 1.0
				value = max(0.0, value)
				player_stats["hunger"] = value
				SaveLoad.save_game(player_stats)

		if value <= 0:
				if $Timer.is_stopped():
						return
				$Timer.stop()
				
				print("Oops! player died from starving. Resetting hunger to 100.")
				
				player_stats["hunger"] = 100.0
				SaveLoad.save_game(player_stats)
				value = 100.0
				$Timer.start()
