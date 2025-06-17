extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self.interact)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _interact(player):
	print("Hello " + player.name)
