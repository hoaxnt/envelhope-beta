extends Control

@onready var anim = $AnimationPlayer

const IMAGES = [
	"res://assets/utils/introduction/scene_1.jpg",
	"res://assets/utils/introduction/scene_2.jpg",
	"res://assets/utils/introduction/scene_3.jpg",
	"res://assets/utils/introduction/scene_3.jpg",
]

const DIALOGUE_TEXT = [
	"Somewhere from part of southwest Philippines there was an island called Wati Wati",
	"There was a boy named Rico that experiencing the beautiful life in the island",
	"They used to harvest plants and fishing in the sea",
	"And now you will experience the journey here in the island that is rich in natural resources",
]

const NEXT_SCENE_PATH = "res://scenes/chapters/chapter_1.tscn"

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
	print("STORY DONE")
	if is_transitioning:
		return
	is_transitioning = true
	
	GlobalData.update_config_data("is_new_game", true)
	print("new game: ", GlobalData.config.get("is_new_game"))

	
	Transition.transition_to_scene(NEXT_SCENE_PATH)
	
