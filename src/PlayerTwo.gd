extends CharacterBody2D
@export var SPEED = 100.0

@export var is_artificial = false
@onready var ball = $"../Ball"
@export var tracking_speed = Vector2(0.2, 2.0)

# the side of the arena the ball is on
enum BallSide {PLAYER, AI}

func _ready():
	pass

func _physics_process(delta):
	if is_artificial:
		position.y = move_toward(position.y, ball.position.y, randf_range(tracking_speed.x, tracking_speed.y))
	else:
		if Input.is_action_pressed("ui_up"):
			position.y -= SPEED * delta
		if Input.is_action_pressed("ui_down"):
			position.y += SPEED * delta
