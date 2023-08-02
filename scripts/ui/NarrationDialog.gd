extends PanelContainer

signal ADVANCE_BEAT

@onready var label = $"MarginContainer/VBoxContainer/Label"
@onready var timer = $"Text Display Timer"

var text:String:
	set(value):
		text = value
		label.text = text
		label.visible_characters = 0
		timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", _on_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer():
	label.visible_characters += 1


func _on_advance_button_pressed():
	if (label.visible_characters < label.text.length()):
		label.visible_characters = label.text.length()
	else:
		ADVANCE_BEAT.emit()
