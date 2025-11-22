extends Node2D

var state = "no pearl"  #pearl / no pearl"
var player_in_area = false

func _ready():
	if state == "no pearl" :
		$spawn_timer.start()
		
func _process(delta):
	if state == "no pearl":
		$AnimatedSprite2D.play("no pearl")
	if state == "pearl":
		$AnimatedSprite2D.play("pearl")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				print(" + 1 pearl")
				state = "no pearl"
				$spawn_timer.start()
				

	


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true


func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
