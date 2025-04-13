extends VBoxContainer

# when pressing any of the bottom buttons, the menu will close
func _on_exit_button_pressed() -> void:
	visible = false

## exit logic here would make more sense, but this would probably use a generic Menu class
## for now, this logic will stay in main
# func _process(_delta: float) -> void:

# 	if Input.is_action_just_pressed("pause"):
# 		visible = false