extends Area2D

@onready var item_label: Label = $Label
@onready var sfx = StreamAudio.get_node("Sfx")
@export var item_name: String
@export var icon: CompressedTexture2D = null
@export var interaction_key: Key = KEY_E
@export var player_tag: String = "player"

var player_in_range: bool = false
var player_body: Node2D = null

func _ready():
	item_label.hide()
	if GlobalData.config.get("user_opened_once") == false:
		InventoryManager.remove_item("Axe")
	
	if item_name == "Axe":
		hide()
	if item_name == "Axe" and GlobalData.config.get("user_opened_once"):
		if GlobalData.get_player_data_value("has_axe"):
			if InventoryManager:
				InventoryManager.remove_item(item_name)
				InventoryManager.add_item(item_name)
			queue_free()
			print("Already have Axe!")
	
	if !has_node("/root/InventoryManager"):
		push_error("Error: InventoryManager Autoload is missing or incorrectly named.")

func _on_body_entered(body: Node2D):
	if body.is_in_group(player_tag):
		item_label.show()
		player_in_range = true
		player_body = body

func _on_body_exited(body: Node2D):
	if body == player_body:
		item_label.hide()
		player_in_range = false
		player_body = null

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		_pick_up()

func _pick_up():
	sfx.stream = StreamAudio.interact
	sfx.play()
	
	if item_name == "Axe":
		GlobalData.update_player_data("has_axe", true)
	print("Picked up: " + item_name)
	if InventoryManager:
			InventoryManager.add_item(item_name)
	queue_free()
