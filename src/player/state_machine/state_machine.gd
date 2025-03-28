extends Node
class_name StateMachine


var player: Player
var states: Dictionary[String, State] = {
    "walk": Walk.new(),
    "idle": Idle.new(),
    "run": Run.new(),
    "jump": Jump.new(),
    "leap": Leap.new(),
    "airborne": Airborne.new()
}

var current_state: State = states["jump"]:
    set(value):
        current_state.exit()
        current_state = value
        current_state.enter()
        
func _init(player_: Player) -> void:
    player = player_

    for state in states.values():
        state.player = player
        state.state_machine = self

func change_state(new_state_name: String):
    if new_state_name in states:
        current_state = states[new_state_name]
        player.state_label.text = new_state_name.to_upper()

func physics_update(delta: float) -> void:
    current_state.physics_update(delta)
        