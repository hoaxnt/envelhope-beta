extends Node

@onready var PLAYER_DATA_PATH = SaveLoad.PLAYER_DATA_PATH
@onready var CONFIG_PATH = SaveLoad.CONFIG_PATH
@onready var ISLAND_NPC_PATH = SaveLoad.ISLAND_NPC_PATH

var PLAYER_STATS = {
	"hunger": 100.0,
	"envelopes": 10000,
	"cycle": 10,
	"equipped_tool": "none",
}

var ISLAND_NPC_STATS = {
	"diver": {
		"name": "Diver",
		"dialogue": {
			"1": "Rico! The tide is perfect! Are you ready to dive for the season's first pearls? They say it's going to be a bountiful harvest!",
			"2": "This is the time to dive regularly and make a fortune, but we've run into a serious problem...",
			"3": "Our current boat is wrecked beyond repair. We need to craft a completely new one, and I'm missing the right materials.",
			"4": "Can you help me gather some woods?",
		}
	},
	"diver_gather_woods": {
		"name": "Diver",
		"dialogue": {
			"1": "Comeback to me if you're done",
		}
	},
	"harvester": {
		"name": "Harvester",
		"dialogue": {
			"1": "This island is full of natural resources",
			"2": "You won't starve in this island",
		}
	},
	"balancer": {
		"name": "Balancer",
		"dialogue": {
			"1": "Our ancestors used to dive for pearls and make beautiful accessories out of it",
			"2": "Isn't it amazing?",
			"3": "Maybe not Hahaha!",
		}
	},
	"current_objective": "none",
	"list_of_objectives": {
		"gather_woods": "OBJECTIVE: Gather 30 woods and give it to Diver",
	}
}

func _ready() -> void:
	SaveLoad.save_game(PLAYER_STATS, PLAYER_DATA_PATH)
	SaveLoad.save_game(ISLAND_NPC_STATS, ISLAND_NPC_PATH)
	
