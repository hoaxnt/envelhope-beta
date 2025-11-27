extends Label

func _ready() -> void:
	text = str(int(GlobalData.player_data.get("envelopes")))
	
func _on_timer_timeout() -> void:
	text = str(int(GlobalData.player_data.get("envelopes")))
