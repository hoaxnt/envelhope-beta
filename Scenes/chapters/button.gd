extends Button

var root_viewport = get_tree().root

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed", self.vanish)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func vanish():
	
	pass
	
	
