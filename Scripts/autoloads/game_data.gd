extends Node

@onready var PLAYER_DATA_PATH = SaveLoad.PLAYER_DATA_PATH
@onready var CONFIG_PATH = SaveLoad.CONFIG_PATH

var player_stats = {
	"hunger": 100.0,
	"envelopes": 10000,
	"cycle": 10
}

func _ready() -> void:
	SaveLoad.save_game(player_stats, PLAYER_DATA_PATH)
	
