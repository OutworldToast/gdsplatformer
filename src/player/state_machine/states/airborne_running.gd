extends Airborne
class_name AirborneRunning


func enter() -> void:
    player.sprite.play("leap")

func physics_update(delta) -> void:

    player.velocity += player.get_gravity() * delta
    
    ## it might be possible to fly if you jump on the same tick you hit the ground
    if Input.is_action_just_pressed("jump"):
        player.jump(true)
        request_state.emit("leap")

    if Input.is_action_just_released("run"):
        request_state.emit("airborne")

    if player.is_on_wall():
        request_state.emit("cling")

    check_landing("run")
