extends State
class_name Run

func enter() -> void:
    player.sprite.play("run")


func physics_update(_delta):

    ## kind of sloppy, should prob use super() somehow
    move(get_input_direction(), player.RUN_MODIFIER)

    if not Input.is_action_pressed("run"):
        request_state.emit("walk")

    if not get_input_direction():
        request_state.emit("idle")

    if Input.is_action_just_pressed("jump"):
        player.jump(true)
        request_state.emit("leap")

    if not player.is_on_floor():
        request_state.emit("airborne_running")
