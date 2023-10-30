extends CharacterBody2D

const SPEED = 100.0

@export var direction = Vector2(-1, 0)
@onready var arena_center = get_viewport_rect().size / 2
@onready var goal_timer = $GoalTimer

var collision_data
signal player_one_goal
signal player_two_goal

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity += SPEED * direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	collision_data = move_and_collide(velocity * delta)	
	if collision_data:
		velocity.y += randf_range(-20, 20)
		velocity = velocity.bounce(collision_data.get_normal())
		
		var collider_name = collision_data.get_collider().name
		if collider_name == "Player" or collider_name == "PlayerTwo":
			velocity += (Vector2(0.5, 0) * velocity.normalized())
		if collider_name == "RightGoal":
			print("test")
			position = arena_center 
		if collider_name == "LeftGoal":
			position = arena_center

## Should this be handled by the ball? or the world.
func _on_left_goal_body_entered(_body):
	velocity = Vector2.ZERO
	position = arena_center
	goal_timer.start()
	emit_signal("player_two_goal")
	direction = Vector2(1, 0)
	print("2 goal!")


func _on_right_goal_body_entered(_body):
	velocity = Vector2.ZERO
	position = arena_center
	goal_timer.start()
	emit_signal("player_one_goal")
	direction = Vector2(-1, 0)
	print("1 goal!")

func _on_goal_timer_timeout():
	velocity += SPEED * direction
