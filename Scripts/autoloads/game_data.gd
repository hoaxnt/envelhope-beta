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
	"diver_gather_woods_completed": {
		"name": "Diver",
		"dialogue": {
			"1": "Here's the boat, you can use it anytime you want, thankyou!"
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
	"diver_objective": "none",
	"list_of_objectives": {
		"gather_woods": "OBJECTIVE: Gather 15 woods and give it to Diver",
	}
}

func _ready() -> void:
	SaveLoad.save_game(PLAYER_STATS, PLAYER_DATA_PATH)
	SaveLoad.save_game(ISLAND_NPC_STATS, ISLAND_NPC_PATH)
	
