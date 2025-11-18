extends Panel

@onready var db = get_parent()

func _ready() -> void:
	db.visible = false
