extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var hud : CanvasLayer = $Hud
@onready var data = SaveLoad.load_game(SaveLoad.CONFIG_PATH)

func _ready() -> void:
	ObjectiveLabel.display()
	if data.get("user_opened_once") == false:
		Tutorial.show()
	else:
		Tutorial.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
