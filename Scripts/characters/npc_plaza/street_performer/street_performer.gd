extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self.interact)
	#get_child(2).text = self.name
	print(get_child(1).name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact(player):
	print("Hello " + player.name)
