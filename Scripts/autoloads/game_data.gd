extends Node

@onready var PLAYER_DATA_PATH = SaveLoad.PLAYER_DATA_PATH
@onready var CONFIG_PATH = SaveLoad.CONFIG_PATH
@onready var NPC_DATA_PATH = SaveLoad.NPC_DATA_PATH
@onready var INVENTORY_PATH = SaveLoad.INVENTORY_PATH

var INVENTORY = {
	"Log" : 0,
}

var CONFIG = {
	"user_opened_once": false,
}

var PLAYER_STATS = {
	"hunger": 100.0,
	"envelopes": 100,
	"cycle": 10,
	"equipped_tool": "none",
	"position": [80.0, 486.0],
}

var NPC_DATA_STATS = {
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
			"1": "It's usually peaceful, but we've had trouble recently.",
			"2": "A pirate fleet has been sighted, making our supply routes very dangerous.",
			"3": "We desperately need to get food supplies to the neighboring village, but the pirate activity is high.",
			"4": "Would you be willing to help us deliver the food while avoiding the pirates?"
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
	"diver_objective": "none",#fortest
	"list_of_objectives": {
		"gather_woods": "OBJECTIVE: Gather 15 woods and give it to Diver",
		"survive_day_1": "OBJECTIVE: Find job and buy some food",
		"survive_day_2": "OBJECTIVE: Survive the Day 2",
		"survive_day_3": "OBJECTIVE: Survive the Day 3",
		"survive_day_4": "OBJECTIVE: Dive for some junk",
	},	"day": 1,
	"release_the_kraken": false,
}

func _ready() -> void:
	#SaveLoad.save_game(PLAYER_STATS, PLAYER_DATA_PATH)
	#SaveLoad.save_game(NPC_DATA_STATS, NPC_DATA_PATH)
	#SaveLoad.save_game(INVENTORY, INVENTORY_PATH)
	pass
