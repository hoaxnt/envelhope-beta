extends ProgressBar

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
@onready var envelopes = PLAYER_DATA.get("envelopes")
@onready var timer = $Timer
@onready var hunger_status = PLAYER_DATA.get("hunger", 100.0)

func _ready():
#		Max value displayed on HUDs
		max_value = 100.0
		
#		Displayed current hunger value
		value = hunger_status
		
		if is_instance_valid(timer):
				timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
		if value > 0:
				value -= 1
				value = max(0.0, value)
				PLAYER_DATA.set("hunger", value)
				SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)

		if value <= 0:
				if $Timer.is_stopped():
						return
				$Timer.stop()
				envelopes -= 500
				
				PLAYER_DATA.set("hunger", 100)
				PLAYER_DATA.set("envelopes", envelopes)
				SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)
				value = 100.0
				$Timer.start()
