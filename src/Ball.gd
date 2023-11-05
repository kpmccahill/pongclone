extends CharacterBody2D

@export var SPEED = 100.0


@export var direction = Vector2(-1, 0)
@onready var arena_center = get_viewport_rect().size / 2

@onready var goal_timer = $GoalTimer
@export var paddle_impulse = 0.0

@onready var left_goal = $"../Arena/LeftGoal"
@onready var right_goal = $"../Arena/RightGoal"

@onready var audio_stream_player = $AudioStreamPlayer

@onready var goal_sound = preload("res://assets/sounds/goal.wav")
@onready var goal2_sound = preload("res://assets/sounds/goal2.wav")

@onready var soft_bounce_sound = preload("res://assets/sounds/softbounce.wav")
@onready var soft_bounce2_sound = preload("res://assets/sounds/softbounce2.wav")

# Might not use these
# @onready var bounce_sound = preload("res://assets/sounds/bounce.wav")
# @onready var bounce2_sound = preload("res://assets/sounds/bounce2.wav")

var bounce_array: Array = []

var collision_data
signal player_one_goal
signal player_two_goal

# Called when the node enters the scene tree for the first time.
func _ready():
	#velocity += SPEED * direction
	
	# start the timer so that the game doesnt just start immediately.
	goal_timer.wait_time = 5
	goal_timer.start()
	
	# signals
	left_goal.body_entered.connect(_on_left_goal_body_entered)
	right_goal.body_entered.connect(_on_right_goal_body_entered)
	
	bounce_array.append(soft_bounce_sound)
	bounce_array.append(soft_bounce2_sound)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	collision_data = move_and_collide(velocity * delta)	
	if collision_data:
		# Setup for sounds.
		var sound_selection = randi() % 2
		audio_stream_player.stream = bounce_array[sound_selection]
		audio_stream_player.play()

		# might not need this
		velocity.y += randf_range(-20, 20)

		# collider data.
		var collider_velocity = collision_data.get_collider_velocity()
		var collider_velocity_normal = collider_velocity.normalized()
		velocity = velocity.bounce(collision_data.get_normal()) #+ collider_velocity_normal * 50
		
		# filters out wall bounces.
		var collider_name = collision_data.get_collider().name
		if collider_name == "Player" or collider_name == "PlayerTwo":
			velocity += collider_velocity * paddle_impulse

## Should this be handled by the ball? or the world.
func _on_left_goal_body_entered(_body):
	# play audio
	audio_stream_player.stream = goal_sound
	audio_stream_player.play()

	# stop movement
	velocity = Vector2.ZERO
	direction = Vector2(-1, 0)
	
	goal_timer.start()
	emit_signal("player_two_goal")
	print("2 Goal!")

func _on_right_goal_body_entered(_body):
	# play audio
	audio_stream_player.stream = goal2_sound
	audio_stream_player.play()

	# stop movement
	velocity = Vector2.ZERO
	direction = Vector2(-1, 0)
	
	goal_timer.start()
	emit_signal("player_one_goal")
	print("1 Goal!")

func _on_goal_timer_timeout():
	velocity += SPEED * direction
