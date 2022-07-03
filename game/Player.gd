extends Node2D
class_name PongPlayer

export var left = true
var _motion = 0
const SPEED = 150

onready var _screen_size_y = get_viewport_rect().size.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	# Is the master of the paddle.
	if is_network_master():
		_motion = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

#		if not _you_hidden and _motion != 0:
#			_hide_you_label()

		_motion *= SPEED

		# Using unreliable to make sure position is updated as fast
		# as possible, even if one of the calls is dropped.
		rpc_unreliable("set_pos_and_motion", position, _motion)
	else:
#		if not _you_hidden:
#			_hide_you_label()
		pass

	translate(Vector2(0, _motion * delta))

	# Set screen limits.
	position.y = clamp(position.y, 16, _screen_size_y - 16)


# Synchronize position and speed to the other peers.
puppet func set_pos_and_motion(pos, motion):
	position = pos
	_motion = motion

func _on_PaddleArea_area_entered(area: Area2D) -> void:
	assert(area.get_parent() is Ball)
	
	var ball = area.get_parent() as Ball
	# TODO rpc
	ball.bounce(left, randf())
	
