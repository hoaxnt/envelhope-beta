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
	"is_new_game": false,
	"current_chapter": "none",
}

var PLAYER_STATS = {
	"current_chapter": "none",
	"hunger": 100.0,
	"envelopes": 0, #fortest
	"cycle": 10,
	"equipped_tool": "none",
	"position_1": [628.0, 280.0],
	"position_2": [140.0, 500.0], #fortest
	"has_hat": false, #static
	"has_axe": false
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
		"name": "Rambo",
		"dialogue": {
			"1": "It's usually peaceful, but we've had trouble recently.",
			"2": "A pirate fleet has been sighted, making our supply routes very dangerous.",
			"3": "We desperately need to get food supplies to the neighboring village, but the pirate activity is high.",
			"4": "Would you be willing to help us deliver the food while avoiding the pirates?"
		}
	},
	"noriel": {
		"name": "Noriel",
		"dialogue": {
			"1": "Our ancestors used to dive for pearls and make beautiful accessories out of it",
			"2": "Isn't it amazing?",
			"3": "Maybe not Hahaha!",
		}
	},
	"current_objective": "none",
	"diver_objective": "none",#fortest 
	"list_of_objectives": {
		"gather_woods": "OBJECTIVE: Gather 10 woods and give it to Diver (Tip: Find an axe to cut trees)",
		"survive_day_1": "OBJECTIVE: Find job and buy some food",
		"survive_day_2": "OBJECTIVE: Survive the Day 2",
		"survive_day_3": "OBJECTIVE: Survive the Day 3",
		"survive_day_4": "OBJECTIVE: Dive for some junk",
	},	"day": 1,
	"release_the_kraken": false,
}
