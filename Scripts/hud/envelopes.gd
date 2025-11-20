extends Label

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
@onready var envelopes = PLAYER_DATA.get("envelopes")

func _ready():
	update_display(int(envelopes))
	
func _on_timer_timeout() -> void:
	PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
	envelopes = PLAYER_DATA.get("envelopes")	
	update_display(int(envelopes))

func update_display(new_value):
	text = str(new_value)
	
