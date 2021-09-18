extends VehicleBody

export var MAX_ENGINE_FORCE: float
export var BRAKE_FORCE: float
export var MAX_STEER_ANGLE: float
export var STEER_SPEED: float
export var ROTATION_FORCE: float

func _physics_process(delta):
	var engine = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var steer = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	engine_force = engine * MAX_ENGINE_FORCE
	brake = BRAKE_FORCE if engine != sign(transform.basis.xform_inv(linear_velocity).z) else 0.0
	var steer_target = steer * MAX_STEER_ANGLE
	if (steer_target < steering):
		steering -= STEER_SPEED * delta
		if (steer_target > steering): steering = steer_target
	elif steer_target > steering:
		steering += STEER_SPEED * delta
		if (steer_target < steering): steering = steer_target
	var axis = transform.basis.x.rotated(transform.basis.y, steering * PI / 2)
	apply_torque_impulse(-axis * engine * ROTATION_FORCE)
