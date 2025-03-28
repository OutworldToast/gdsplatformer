extends CharacterBody2D
class_name Player

signal eaten_food

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_label: Label = $StateLabel

const SPEED := 300.0
const RUN_MODIFIER := 1.5

const JUMP_VELOCITY := -400.0
const LEAP_MODIFIER := 0.8

var state_machine := StateMachine.new(self)

func jump(is_running: bool) -> void:

	var modifier := 1.0 if not is_running else LEAP_MODIFIER

	velocity.y = JUMP_VELOCITY * modifier

func _physics_process(delta: float) -> void:

	state_machine.physics_update(delta)

	move_and_slide()


func _on_mouth_area_entered(area: Area2D) -> void:
	print('eat da food! ', area.name)
	area.queue_free()
	eaten_food.emit()
