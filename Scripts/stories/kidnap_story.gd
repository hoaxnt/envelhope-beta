extends Control

@onready var anim = $AnimationPlayer

const IMAGES = [
	"res://assets/utils/kidnap/1.PNG",
	"res://assets/utils/kidnap/2.PNG",
	"res://assets/utils/kidnap/3.PNG",
	"res://assets/utils/kidnap/4.PNG",
]

const DIALOGUE_TEXT = [
	"On an unexpected day, unknown people arrived on Rico's island.",
	"They forcibly took him. And he couldn't do anything because there were so many of them.",
	"He was blindfolded, he didn't know where he was being taken.",
	"He was just surprised when he was left in a place he was unfamiliar with. A place far from where he grew up.",
]

const NEXT_SCENE_PATH = "res://scenes/chapters/chapter_2.tscn"

var current_step: int = 0
var is_transitioning: bool = false 

@onready var image_node: TextureRect = $Panel/VBoxContainer/TextureRect
@onready var label_node: Label = $Panel/VBoxContainer/Label
@onready var next_button: Button = $Panel/SkipButton

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
	Transition.transition_to_scene(NEXT_SCENE_PATH)
	
