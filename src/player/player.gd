extends CharacterBody2D
class_name Player

signal eaten_food

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_label: Label = $StateLabel

@onready var bite_sound: AudioStreamPlayer = $BiteSound
# timers created in player, as states are not nodes 
var detach_buffer_timer: Timer = Timer.new()
var wall_jump_hang_timer: Timer = Timer.new()

const SPEED := 300.0
const RUN_MODIFIER := 1.5

const JUMP_VELOCITY := -400.0
const LEAP_MODIFIER := 0.8

const CLING_MODIFIER := 0.3
const CLING_DETACH_BUFFER_TIME := 0.1

const WALL_JUMP_HANG_TIME := 0.15

var state_machine := StateMachine.new(self)


func _ready() -> void:
	## should probably just be nodes in player
	detach_buffer_timer.wait_time = CLING_DETACH_BUFFER_TIME
	add_child(detach_buffer_timer)

	wall_jump_hang_timer.wait_time = WALL_JUMP_HANG_TIME
	add_child(wall_jump_hang_timer)

	state_machine.state_updated.connect(_on_state_updated)

func jump(is_running: bool) -> void:

	## should maybe be in state for consistency
	## should probably use modifier as variable, similar to move
	var modifier := 1.0 if not is_running else LEAP_MODIFIER

	velocity.y = JUMP_VELOCITY * modifier

func die() -> void:
	# request the new state from the current state
	# this ensures the label is also updated
	state_machine.current_state.request_state.emit("dead")

func celebrate() -> void:
	# request the new state from the current state
	# this ensures the label is also updated
	state_machine.current_state.request_state.emit("victorious")

func _physics_process(delta: float) -> void:

	state_machine.physics_update(delta)

	move_and_slide()


func _on_mouth_area_entered(area: Area2D) -> void:
	if area.is_in_group("eatable"):
		area.queue_free()
		eaten_food.emit()
		bite_sound.play()

func _on_state_updated(new_state_name: String) -> void:
	state_label.text = new_state_name.to_upper()