extends VBoxContainer
class_name SelectorElement

@export var selector_title: String = "SelectorTitle"
@export var selector_items: Array[String] = []

@onready var selector: OptionButton = $Selector

func _ready() -> void:

    $Title.text = selector_title

    set_items(selector_items)

func set_items(items: Array[String]) -> void:

    selector.clear()

    for item in items:
        selector.add_item(item)

    selector.select(-1)