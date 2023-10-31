extends CanvasLayer

@onready var goal_label = $Control/GoalLabel
@onready var player_one_score = $Control/PlayerOneScore
@onready var player_two_score = $Control/PlayerTwoScore
@onready var match_data = $"../MatchData"
@onready var pause_menu = $Control/PauseMenu

# string templates
var player_one_score_text = "1: %d"
var player_two_score_text = "2: %d"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pause_menu.visible = false
	goal_label.visible = false


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_menu.visible = !pause_menu.visible
		var is_paused = get_tree().paused
		get_tree().paused = !is_paused
		if pause_menu.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_one_score.text = player_one_score_text % match_data.player_one_score
	player_two_score.text = player_two_score_text % match_data.player_two_score
