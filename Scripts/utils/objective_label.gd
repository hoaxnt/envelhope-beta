extends Label

@onready var objective_anim = $ObjectiveTextAnimation

func _ready() -> void:
	print(objective_anim)
	objective_anim.play("show_objective")
	
func display() -> void:
	objective_anim.play("show_objective")
	return
