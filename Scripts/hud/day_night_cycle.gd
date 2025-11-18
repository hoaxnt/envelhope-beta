extends Label

const INITIAL_TIME = 300
const SAVE_KEY = "cycle"

var time_left: int = INITIAL_TIME
@onready var timer = $Timer

func _ready():
		var loaded_data = SaveLoad.load_game(SaveLoad.SAVE_PATH)
		var saved_time = loaded_data.get(SAVE_KEY, INITIAL_TIME)
		time_left = saved_time
		
		if is_instance_valid(timer):
				timer.start() 
				if not timer.is_connected("timeout", _on_timer_timeout):
						timer.connect("timeout", _on_timer_timeout)

		update_time_display()

func update_time_display():
		var display_time = max(0, time_left)
		
		var minutes = display_time / 60
		var seconds = display_time % 60
		
		text = "%02d:%02d" % [minutes, seconds]

func _on_timer_timeout():
		if time_left > 0:
				time_left -= 1
				
				save_current_time() 
				
				update_time_display()
		else:
				timer.stop()
				print("Time is up! Cycle ended.")
				
				time_left = INITIAL_TIME
				update_time_display()
				timer.start()
				
				save_current_time()
				
				print("Cycle Restarted.")

func save_current_time():
		var save_data = SaveLoad.load_game(SaveLoad.SAVE_PATH)
		
		save_data[SAVE_KEY] = time_left
		
		SaveLoad.save_game(save_data, SaveLoad.SAVE_PATH)
