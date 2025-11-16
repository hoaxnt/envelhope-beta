extends ProgressBar

var loaded_data = SaveLoad.load_game()
var envelopes

func _ready():
		loaded_data = SaveLoad.load_game()
		envelopes = loaded_data.get("envelopes")
		var saved_hunger = loaded_data.get("hunger", 100.0)
		
		max_value = 100.0
		value = saved_hunger
		loaded_data.set("hunger", saved_hunger)
		var timer = $Timer
		if is_instance_valid(timer):
				timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
		if value > 0:
				value -= 5000.0
				value = max(0.0, value)
				loaded_data.set("hunger", value)
				SaveLoad.save_game(loaded_data)

		if value <= 0:
				if $Timer.is_stopped():
						return
				$Timer.stop()
				envelopes -= 500
				
				print("Oops! player died from starving. Resetting hunger to 100.")
				
				loaded_data.set("hunger", 100)
				loaded_data.set("envelopes", envelopes)
				SaveLoad.save_game(loaded_data)
				value = 100.0
				$Timer.start()
