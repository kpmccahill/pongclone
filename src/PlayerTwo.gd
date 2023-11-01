extends CharacterBody2D
@export var SPEED = 100.0

@onready var ball = $"../Ball"
@onready var arena = $"../Arena"

@export var is_artificial = false
@export var tracking_speed = Vector2(0.2, 2.0)

func _ready():
	pass

func _physics_process(delta):
	if is_artificial and arena.side_state == arena.BallSide.PLAYER_TWO:
		position.y = move_toward(position.y, ball.position.y, tracking_speed.y)
	else:
		if Input.is_action_pressed("ui_up"):
			position.y -= SPEED * delta
		if Input.is_action_pressed("ui_down"):
			position.y += SPEED * delta
