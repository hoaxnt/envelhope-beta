extends Node

@onready var PLAYER_DATA_PATH = SaveLoad.PLAYER_DATA_PATH
@onready var CONFIG_PATH = SaveLoad.CONFIG_PATH
@onready var ISLAND_NPC_PATH = SaveLoad.ISLAND_NPC_PATH

var PLAYER_STATS = {
	"hunger": 100.0,
	"envelopes": 10000,
	"cycle": 10
}

var ISLAND_NPC_STATS = {
	"diver": {
		"name": "Diver",
		"dialogue": {
			"1": "Hi!",
			"2": "I must build a boat in order to dive for pearls, can you help me?",
			"3": "please",
			"4": "pleaseee...",
		}
	},
	"harvester": 2,
	"balancer": 3,
}

func _ready() -> void:
	SaveLoad.save_game(PLAYER_STATS, PLAYER_DATA_PATH)
	SaveLoad.save_game(ISLAND_NPC_STATS, ISLAND_NPC_PATH)
	
