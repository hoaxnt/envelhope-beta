extends Label

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
var envelopes

func _ready():
	envelopes = int(PLAYER_DATA["envelopes"])
	text = str(envelopes)
	
func _on_timer_timeout() -> void:
	PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
	envelopes = int(PLAYER_DATA["envelopes"])
	text = str(envelopes)

	
