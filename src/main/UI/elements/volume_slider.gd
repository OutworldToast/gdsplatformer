extends VBoxContainer

## created following this tutorial https://www.youtube.com/watch?v=aFkRmtGiZCw

@export var bus_name: String = "Master"
@export var slider_description: String = "Volume"

@onready var slider: VSlider = $VSlider

var bus_index: int

func _ready() -> void:

	$Label.text = "%s\n%d" % [slider_description, int(slider.value)]
	bus_index = AudioServer.get_bus_index(bus_name)

func _on_volume_slider_value_changed(value: float) -> void:

	if bus_index == -1:
		printerr("Bus not found: %s" % bus_name)
		return

	var linear_value: float = value / 100.0

	AudioServer.set_bus_volume_linear(bus_index, linear_value)
	$Label.text = "%s\n%d" % [slider_description, int(value)]
