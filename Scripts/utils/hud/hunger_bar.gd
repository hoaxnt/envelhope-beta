extends ProgressBar

func _ready():
		var timer = $Timer 
		timer.connect("timeout", _on_timer_timeout)
		max_value = 100.0
		value = 100.0
		
func _on_timer_timeout():
		if value > 0:
				value -= 1.0
		else:
				$Timer.stop()
				print("Oops! player died from starving.")
