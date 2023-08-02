extends PanelContainer

signal SELECTED(index)

@onready var choices_list = $"MarginContainer/Choices"
@onready var choice_prefab = $"MarginContainer/Choices/Choice Button"

var choices:Array[String]:
	set(value):
		choices = value
		initButtons()

# Called when the node enters the scene tree for the first time.
func _ready():
	choices_list.get_child(0).pressed.connect(onChoice.bind(0))


func initButtons():
	var button
	
	while choices_list.get_child_count() > 1:
		button = choices_list.get_child(choices_list.get_child_count() - 1)
		choices_list.remove_child(button)
		button.queue_free()
		
	for choice_index in range(choices.size()):
		if (choice_index == 0):
			choices_list.get_child(0).text = choices[choice_index]
		else:
			choices_list.add_child(choice_prefab.duplicate())
			choices_list.get_child(choice_index).text = choices[choice_index]
			choices_list.get_child(choice_index).pressed.connect(onChoice.bind(choice_index))


func onChoice(choice_index):
	visible = false
	SELECTED.emit(choice_index)
