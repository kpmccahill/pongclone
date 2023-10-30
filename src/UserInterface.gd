extends CanvasLayer

@onready var goal_label = $Control/GoalLabel
@onready var player_one_score = $Control/PlayerOneScore
@onready var player_two_score = $Control/PlayerTwoScore
@onready var match_data = $"../MatchData"

# string templates
var player_one_score_text = "1: %d"
var player_two_score_text = "2: %d"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_one_score.text = player_one_score_text % match_data.player_one_score
	player_two_score.text = player_two_score_text % match_data.player_two_score
