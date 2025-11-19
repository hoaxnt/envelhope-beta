extends Label

@onready var objective_anim = $ObjectiveTextAnimation

func _ready() -> void:
	#objective_anim.play("show_objective")
	pass
	
func display() -> void:
	objective_anim.play("show_objective")
	return
