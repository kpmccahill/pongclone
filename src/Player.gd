extends CharacterBody2D

@export var SPEED = 100

func _ready():
	pass

func _physics_process(delta):
	
	# wanna put move_toward here
	if Input.is_action_pressed("player_up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("player_down"):
		position.y += SPEED * delta
	# if input.is_action_pressed("player_up"):
	# 	position.y -= speed * delta
	# if input.is_action_pressed("player_down"):
	# 	sition.y += SPEED * delta
