extends Label

@onready var timer = $Timer
@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
@onready var time = PLAYER_DATA.get("cycle", 300)

var time_left: int = 300

func _ready():
		time_left = time
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
				
				time_left = 300
				update_time_display()
				timer.start()
				
				save_current_time()
				
				print("Cycle Restarted.")

func save_current_time():
		PLAYER_DATA["cycle"] = time_left
		SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)
