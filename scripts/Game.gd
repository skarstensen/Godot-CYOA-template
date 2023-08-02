extends Node

@onready var title_screen = $"Title Screen"
@onready var story_screen = $"Story Screen"

# Called when the node enters the scene tree for the first time.
func _ready():
	title_screen.visible = true


# BASE UI NAVIGATION
func _on_new_game_button_pressed():
	title_screen.visible = false
	story_screen.visible = true
	
	story_screen.startStory()


func _on_end_of_story():
	title_screen.visible = true
	story_screen.visible = false
