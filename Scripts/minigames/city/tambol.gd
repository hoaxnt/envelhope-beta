extends Node2D

@onready var slider_bar: ProgressBar = $CanvasLayer/Control/SliderBar
@onready var target = $CanvasLayer/Control/SliderBar/TargetZone
@onready var earnings_label: Label = $CanvasLayer/Control/EarningsLabel
@onready var instructions_panel = $CanvasLayer/Instructions
@onready var anim = $CanvasLayer/AnimationPlayer
@onready var countdown_label = $CanvasLayer/Label
@onready var summary_panel = $CanvasLayer/SummaryPanel
@onready var summary_label = $CanvasLayer/SummaryPanel/HBoxContainer/VBoxContainer/SummaryLabel
@onready var dancer_anim = $AnimatedSprite2D
@onready var player = get_node("/root/Chapter2/Player")
@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)

var earnings = 0
var sfx = StreamAudio.get_node("Sfx")

var speed: float = 150.0
var direction: int = 1
var is_moving: bool = false

const TARGET_MIN_VALUE: float = 45.0
const TARGET_MAX_VALUE: float = 55.0

func _ready():
	instructions_panel.show()
	summary_panel.hide()
	target.hide()
	slider_bar.hide()
	slider_bar.value = 0.0

func _process(delta):
	if is_moving:
		var new_value = slider_bar.value + speed * direction * delta
		
		slider_bar.value = clampf(new_value, slider_bar.min_value, slider_bar.max_value)
		if slider_bar.value == slider_bar.max_value or slider_bar.value == slider_bar.min_value:
			direction *= -1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and is_moving:
		stop_slider()

func stop_slider():
	if slider_bar.value >= TARGET_MIN_VALUE and slider_bar.value <= TARGET_MAX_VALUE:
		earnings += 10
		earnings_label.text = "Envelopes: %s" % str(earnings)
	else:
		if earnings < 3:
			earnings = 0
			earnings_label.text = "Envelopes: %s" % str(earnings)
			return
		earnings -= 3
		earnings_label.text = "Envelopes: %s" % str(earnings)


func _on_start_button_pressed() -> void:
	instructions_panel.hide()
	countdown_label.show()
	anim.play("countdown")
	await anim.animation_finished
	
	target.show()
	slider_bar.show()
	sfx.stream = StreamAudio.badjao
	sfx.play()
	dancer_anim.play("default")
	is_moving = true
	
	await sfx.finished
	
	dancer_anim.stop()
	target.hide()
	slider_bar.hide()
	earnings_label.hide()
	is_moving = false
	
	summary_label.text = "You've earned %s Envelopes!" % str(earnings)
	
	var current_envelopes = GlobalData.get_player_data_value("envelopes")
	var new_total_envelopes = current_envelopes + earnings
	GlobalData.update_player_data("envelopes", new_total_envelopes)
	summary_panel.show()

func _on_done_button_pressed() -> void:
	if player:
		player.position = GlobalData.load_player_position()
	Transition.transition_to_scene("res://scenes/chapters/chapter_2.tscn")
