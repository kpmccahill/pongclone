extends Node2D

@onready var ball = $"../Ball"

@export var center_offset = 20
var center_pos
# signals to tell AI which side the ball is on.
signal player_side
signal player_two_side

enum BallSide {START, PLAYER, PLAYER_TWO}
@onready var side_state = BallSide.START
# Called when the node enters the scene tree for the first time.
func _ready():
	center_pos = position.x - center_offset
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if center_pos >= ball.position.x and side_state != BallSide.PLAYER:
		player_side.emit()
		side_state = BallSide.PLAYER
	elif center_pos <= ball.position.x and side_state != BallSide.PLAYER_TWO:
		player_two_side.emit()
		side_state = BallSide.PLAYER_TWO
