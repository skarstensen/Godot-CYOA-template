extends Control

signal END_OF_STORY

@export var story_flow:PackedScene

@onready var narration_dialog = $"Narration Dialog"
@onready var choices_dialog = $"Choices Dialog"

var start_beat
var current_beat

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func startStory():
	start_beat = story_flow.instantiate()
	current_beat = start_beat
	narrate(current_beat)


func narrate(beat):
	narration_dialog.visible = true
	narration_dialog.text = beat.text
	narration_dialog.get_node("MarginContainer/VBoxContainer/Advance Button").visible = true


func _on_advance_beat():
	if (current_beat.jumpToNode != ""):
		jumpToNode(current_beat.jumpToNode)
				
	if (current_beat.get_child_count() == 0):
		END_OF_STORY.emit()
	else:
		if (current_beat.choices.size() > 0):
			narration_dialog.get_node("MarginContainer/VBoxContainer/Advance Button").visible = false
			choices_dialog.visible = true
			choices_dialog.choices = current_beat.choices
		else:
			choices_dialog.visible = false
			current_beat = current_beat.get_child(0)
			narrate(current_beat)


func _on_choice_selected(index):
	current_beat = current_beat.get_child(index)
	narrate(current_beat)


func jumpToNode(path):
	current_beat = start_beat.get_node(path)
	narrate(current_beat)
