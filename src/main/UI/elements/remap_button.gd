extends HBoxContainer
class_name RemapButton

signal selected()

@export var action_name: String = "Action"
@export var action_identifier: String = "action_identifier"

func _ready() -> void:
	$Label.text = "%s:" % action_name
	set_button_text()
	set_process_unhandled_input(false)

func set_button_text() -> void:
	var input: InputEvent = InputMap.action_get_events(action_identifier).back()
	if input == null:
		$Button.text = "None"
	else:
		$Button.text = input.as_text()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:

		for action in InputMap.get_actions():
			for keybind: InputEvent in InputMap.action_get_events(action):
				if keybind.is_match(event):
					InputMap.action_erase_events(action)

		InputMap.action_erase_events(action_identifier)
		InputMap.action_add_event(action_identifier, event)

		$Button.button_pressed = false

func _on_button_toggled(toggled_on: bool) -> void:

	if toggled_on:
		selected.emit()
		$Button.text = "Press a key"
	else:
		set_button_text()

	set_process_unhandled_input(toggled_on)
