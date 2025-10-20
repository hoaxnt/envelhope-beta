extends Label

const INITIAL_TIME = 300

var time_left: int = INITIAL_TIME
@onready var timer = $Timer

func _ready():
		update_time_display()
		
		timer.connect("timeout", _on_timer_timeout)

func update_time_display():
		var display_time = max(0, time_left)
		
		var minutes = display_time / 60
		var seconds = display_time % 60
		
		text = "%02d:%02d" % [minutes, seconds]

func _on_timer_timeout():
		if time_left > 0:
				time_left -= 1
				
				update_time_display()
		else:
				timer.stop()
				print("Time is up!")
				
func get_time_to_save() -> int:
		return time_left
