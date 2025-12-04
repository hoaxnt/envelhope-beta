extends Label

func _ready() -> void:
	if GlobalData.player_data:
		text = str(int(GlobalData.player_data.get("envelopes")))
	
func _on_timer_timeout() -> void:
	if GlobalData.player_data:
		text = str(int(GlobalData.player_data.get("envelopes")))
