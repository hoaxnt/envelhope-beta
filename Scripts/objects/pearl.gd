extends Node2D

var state = "no pearl"  #pearl / no pearl"
var player_in_area = false

func _ready():
	if state == "no pearl" :
		$growth_timer.start()
		
func _process(delta):
	if state == "no pearl" :
		$Sprite2D.play("no pearl")
	
