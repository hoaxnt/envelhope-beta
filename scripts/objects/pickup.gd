extends Area2D

@export var item_name: String = "Axe"
@export var icon: CompressedTexture2D = null
@export var interaction_key: Key = KEY_E
@export var player_tag: String = "player"
@onready var item_label: Label = $Label
@onready var sfx = StreamAudio.get_node("Sfx")


var player_in_range: bool = false
var player_body: Node2D = null

func _ready():
	item_label.hide()
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
	print("Picked up: " + item_name)

	if InventoryManager:
			InventoryManager.add_item(item_name)
	queue_free()
