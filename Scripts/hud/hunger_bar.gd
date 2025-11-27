extends ProgressBar

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
@onready var envelopes = PLAYER_DATA.get("envelopes")
@onready var hunger_status = PLAYER_DATA.get("hunger", 100.0)
@onready var hunger_timer = $HungerTimer

func _ready():
		max_value = 100.0
		value = hunger_status

func _on_timer_timeout():
		if value > 0:
				value -= 1 #fortest
				value = max(0.0, value)
				PLAYER_DATA.set("hunger", value)
				SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)

		if value <= 0:
				hunger_timer.stop()
				envelopes = 0 #fortest
				PLAYER_DATA.set("hunger", 100)
				PLAYER_DATA.set("envelopes", envelopes)
				SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)
				value = 100.0
