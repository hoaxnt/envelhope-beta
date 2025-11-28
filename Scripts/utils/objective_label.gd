extends Label

@onready var objective_anim = $ObjectiveTextAnimation
@onready var sfx = StreamAudio.get_node("Sfx")

func  _ready() -> void:
	GlobalData.config_updated.connect(_show_objective_at_first_chapter_1)
	
func _show_objective_at_first_chapter_1(key, value):
	if GlobalData.config.get(key) == value:
		objective_anim.play("show_objective")#fortest
