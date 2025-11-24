extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var musicAudioStreamBG = $"AudioStreamPlayer-BGM"

var backgroundMusicOn = true

func _ready() -> void:
	Hud.show()
	
func _process(_delta):
	update_music_stats()
	
func update_music_stats():
	if backgroundMusicOn:
		if !musicAudioStreamBG.playing:
			musicAudioStreamBG.play()
	else:
		musicAudioStreamBG.stop()
		
		
			
			

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
		
func _on_timer_timeout() -> void:
	if CONFIG.get("user_opened_once") == false:
		tutorial.show()
	else:
		tutorial.hide()
		
