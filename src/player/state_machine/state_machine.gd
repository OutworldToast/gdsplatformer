extends Node
class_name StateMachine

signal state_updated(new_state_name: String)

## would be nice to use const NAMES dictionary
var states: Dictionary[String, State] = {
	"walk": Walk.new(),
	"idle": Idle.new(),
	"run": Run.new(),
	"jump": Jump.new(),
	"leap": Leap.new(),
	"airborne": Airborne.new(),
	"cling": Cling.new(),
	"wall_jump": WallJump.new()
}

var starting_state: State = states["airborne"]

# use setter for exit/enter logic, to ensure behaviour even if variable is set directly
var current_state: State = starting_state:
	set(value):
		current_state.exit()
		current_state = value
		current_state.enter()

func _init(player_: Player) -> void:

	for state in states.values():
		state.player = player_
		state.request_state.connect(_on_state_change_requested)

func physics_update(delta: float) -> void:
	current_state.physics_update(delta)

func _on_state_change_requested(new_state_name: String):

	if new_state_name in states:
		current_state = states[new_state_name]

		## cannot be easily in current_state setter, as it does not have the name anymore
		## as such, it is possible for this not to be emitted if the state is updated directly
		state_updated.emit(new_state_name)
