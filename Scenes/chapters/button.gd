extends Button

var root_node2d  # This will store the parent Node2D
var vendor

func _ready() -> void:
		# Connect button press
		connect("pressed", self.vanish)

		# Traverse up the scene tree until we find a Node2D
		var current = self
		while current and not current is Node2D:
				current = current.get_parent()
		
		root_node2d = current
	
		
		if root_node2d:
				print("Found Node2D:", root_node2d.name)
				vendor = root_node2d.get_child(5)
				print(vendor.name)
				
		else:
				print("Node2D not found in parent chain")

func vanish():
	
	vendor.visible = false
	pass
