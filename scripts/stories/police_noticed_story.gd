extends Control

@onready var anim = $AnimationPlayer
var bgm : AudioStreamPlayer2D = StreamAudio.get_node("Bgm")
var sfx : AudioStreamPlayer2D = StreamAudio.get_node("Sfx")

const IMAGES = [
	"res://assets/utils/ending/noticed.jpg",
]
const DIALOGUE_TEXT = [
	"As the days passed, the police noticed him.",
]
const NEXT_SCENE_PATH = "res://scenes/chapters/chapter_2.tscn"

var current_step: int = 0
var is_transitioning: bool = false 

@onready var image_node: TextureRect = $Panel/VBoxContainer/TextureRect
@onready var label_node: Label = $Panel/VBoxContainer/Label
@onready var next_button: Button = $Panel/SkipButton
@onready var day_timer = Hud.get_node("DayPanel/DayTimer")
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH) 
@onready var police_npc = load("res://scenes/minigames/city/path_finding/police.tscn")
@onready var hunger_timer : Timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")
#var player

func _ready() -> void:
	#if get_node("/root/Chapter2/Player"):
		#player = get_node("/root/Chapter2/Player")
		#
	bgm.volume_db = 20
	bgm.stream = StreamAudio.kidnap
	bgm.play()
	
	hunger_timer.stop()
	anim.play("fade_reveal")
	_update_content()

func _on_skip_button_pressed() -> void:
	current_step += 1
	if current_step < IMAGES.size():
		anim.play("fade_reveal")
		_update_content()
	else:
		_transition_to_next_scene()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		sfx.play()
		current_step += 1
		if current_step < IMAGES.size():
			anim.play("fade_reveal")
			_update_content()
		else:
			_transition_to_next_scene()

func _update_content() -> void:
	if current_step < IMAGES.size() and current_step < DIALOGUE_TEXT.size():
		image_node.texture = load(IMAGES[current_step]) 
		label_node.text = DIALOGUE_TEXT[current_step]
	else:
		print("Error: Step index out of bounds or array sizes don't match.")

func _transition_to_next_scene() -> void:
	if is_transitioning:
		return
	
	is_transitioning = true
	
	#if player:
		#player.position = GlobalData.load_player2_position()
		
	GlobalData.npc_data.set("release_the_kraken", true)
	Transition.transition_to_scene(NEXT_SCENE_PATH)
	
