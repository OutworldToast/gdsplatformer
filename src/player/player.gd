extends CharacterBody2D
class_name Player

signal eaten_food

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var state_machine := StateMachine.new(self)

func _physics_process(delta: float) -> void:

	state_machine.physics_update(delta)

	move_and_slide()


func _on_mouth_area_entered(area: Area2D) -> void:
	print('eat da food! ', area.name)
	area.queue_free()
	eaten_food.emit()
