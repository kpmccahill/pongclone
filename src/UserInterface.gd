extends CanvasLayer


@onready var match_data = $"../MatchData"

@onready var goal_label = $Control/GoalLabel
@onready var player_one_score = $Control/PlayerOneScore
@onready var player_two_score = $Control/PlayerTwoScore

@onready var ball = $"../Ball"
@onready var goal_timer = $"../Ball/GoalTimer"

@onready var game_over_menu = $Control/GameOverMenu
@onready var pause_menu = $Control/PauseMenu

@onready var audio_stream_player = $AudioStreamPlayer
@onready var select_sound = preload("res://assets/sounds/select.wav")

# string templates
var player_one_score_text = "Player 1: %d"
var player_two_score_text = "Player 2: %d"

var player_one_goal_text = "Player 1 Scored!\n%.1f"
var player_two_goal_text = "Player 2 Scored!\n%.1f"
var start_timer_text = "Get Ready!\n%.1f"

enum GoalStates {MATCH_START, PLAYER_ONE, PLAYER_TWO, NONE}
var goal_state = GoalStates.NONE

signal new_match

# Called when the node enters the scene tree for the first time.
func _ready():
	# Making sure most UI elements are hidden.
	pause_menu.visible = false
	#goal_label.visible = false
	game_over_menu.visible = false
	
	# Signals
	ball.player_one_goal.connect(_on_player_one_goal)
	ball.player_two_goal.connect(_on_player_two_goal)
	goal_timer.timeout.connect(_on_goal_timer_timeout)
	
	# Setting start state.
	goal_state = GoalStates.MATCH_START
	
	audio_stream_player.stream = select_sound
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_one_score.text = player_one_score_text % match_data.player_one_score
	player_two_score.text = player_two_score_text % match_data.player_two_score
	
	if goal_label.visible:
		match goal_state:
			GoalStates.MATCH_START:
				goal_label.text = start_timer_text % goal_timer.time_left
			GoalStates.PLAYER_ONE:
				goal_label.text = player_one_goal_text % goal_timer.time_left
			GoalStates.PLAYER_TWO:
				goal_label.text = player_two_goal_text % goal_timer.time_left
			GoalStates.NONE:
				goal_label.visible = false
			_:
				goal_label.visible = false

# pause/unpause
func toggle_pause():
	pause_menu.visible = !pause_menu.visible
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	if pause_menu.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# quit the game
func quit():
	get_tree().quit()

# button handlers
func _on_resume_button_down():
	toggle_pause()
	audio_stream_player.play()
	
func _on_quit_button_down():
	audio_stream_player.play()
	quit()

func _on_restart_button_down():
	new_match.emit()
	get_tree().paused = false
	audio_stream_player.play()

# game flow handlers
func _on_player_one_goal():
	goal_state = GoalStates.PLAYER_ONE
	goal_label.visible = true
	
func _on_player_two_goal():
	goal_state = GoalStates.PLAYER_TWO
	goal_label.visible = true

func _on_goal_timer_timeout():
	goal_label.visible = false
	goal_state = GoalStates.NONE
	goal_label.text = ""

func _on_match_data_game_over(player):
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var game_over_text = "Game Over!\nPlayer %d wins!"
	match player:
		"player_one":
			game_over_text = game_over_text % 1
		"player_two":
			game_over_text = game_over_text % 2
	game_over_menu.find_child("GameOverLabel").text = game_over_text
	game_over_menu.show()
