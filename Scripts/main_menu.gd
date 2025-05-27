extends Node2D

# Called when the node enters the scene tree for the first time
func _ready():
	get_tree().change_scene_to_file("res://Scenes/Chapter2.tscn")
	print("Chapter2 loaded")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
