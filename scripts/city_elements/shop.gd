extends Node

@export var item1_button: Button
@export var not_enough: Label
var current_body_entered : Node2D
var is_shop_entered = false
var item1_price = 0

func _ready() -> void:
	get_child(3).visible = false
	not_enough.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		current_body_entered = body
		get_child(2).visible = true
		is_shop_entered = true
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		current_body_entered = null
		get_child(2).visible = false
		is_shop_entered = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_shop_entered:
		get_child(3).visible = true
	if event.is_action_pressed("w") or event.is_action_pressed("a") or event.is_action_pressed("s") or event.is_action_pressed("d"):
		get_child(3).visible = false
		not_enough.visible = false
		
func _on_item_1_button_pressed() -> void:
	var current_envelopes = GlobalData.get_player_data_value("envelopes")
	if current_envelopes < item1_price:
		print("Not enough envelopes")
		not_enough.visible = true
		return
		
	not_enough.visible = false
	GlobalData.purchase_shop(item1_price)
	item1_button.disabled = true
	item1_button.text = "Owned"
	
	#static
	GlobalData.player_data.set("has_hat", true)
	
	if current_body_entered:
		current_body_entered.get_child(0).visible = true
