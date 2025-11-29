extends Control

@onready var anim = $AnimationPlayer

const IMAGES = [
	"res://assets/utils/death_island/death_island.jpg",
]
const DIALOGUE_TEXT = [
	"nawalan sya ng malay pero tumayo ulet.",
]
const NEXT_SCENE_PATH = "res://scenes/chapters/chapter_1.tscn"

var current_step: int = 0
var is_transitioning: bool = false 

@onready var image_node: TextureRect = $Panel/VBoxContainer/TextureRect
@onready var label_node: Label = $Panel/VBoxContainer/Label
@onready var next_button: Button = $Panel/SkipButton
@onready var day_timer = Hud.get_node("DayPanel/DayTimer")
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH) 
@onready var hunger_timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")

var sfx = StreamAudio.get_node("Sfx")

func _ready() -> void:
	anim.play("fade_reveal")
	_update_content()

func _on_skip_button_pressed() -> void:
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
	
	await Transition.transition_to_scene(NEXT_SCENE_PATH)
	hunger_timer.start()#htimer
