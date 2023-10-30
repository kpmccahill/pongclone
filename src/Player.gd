extends CharacterBody2D

@export var SPEED = 200.0

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("player_up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("player_down"):
		position.y += SPEED * delta
