extends Node
class_name MatchData

@onready var player_one_score: int = 0
@onready var player_two_score: int = 0

@export var max_score = 7

signal game_over(player: String)
# Series score? Not impl yet
# @onready var series_score = Vector2i(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (player_one_score >= max_score) and (player_two_score < max_score):
		game_over.emit("player_one")
	elif (player_two_score >= max_score) and (player_one_score < max_score):
		game_over.emit("player_two")
