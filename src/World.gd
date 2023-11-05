extends Node2D

@onready var ball = $Ball
@onready var arena = $Arena
@onready var player = $Player
@onready var player_two = $PlayerTwo
@onready var match_data = $MatchData
@onready var user_interface = $UserInterface

@onready var arena_center = get_viewport_rect().size / 2

@onready var player_one_starting_pos = Vector2(5, get_viewport_rect().size.y / 2)
@onready var player_two_starting_pos = Vector2(get_viewport_rect().size.x - 5, get_viewport_rect().size.y / 2)
@onready var ball_starting_pos = arena_center

var versus_computer = false

func _init(vs_computer: bool = false):
	#print(vs_computer)
	if vs_computer:
		versus_computer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# could replace all but arena to center but am leaving it bc I'm lazy, and its clearer whats
	# going on.
	ball.position = arena_center
	arena.position = arena_center
	player.position = player_one_starting_pos
	player_two.position = player_two_starting_pos
	player_two.is_artificial = versus_computer

	ball.player_one_goal.connect(_on_ball_player_one_goal)
	ball.player_two_goal.connect(_on_ball_player_two_goal)
	
	user_interface.new_match.connect(reset_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player.position.y = clamp(player.position.y, Vector2.ZERO.y, get_viewport_rect().size.y)
	player_two.position.y = clamp(player_two.position.y, Vector2.ZERO.y, get_viewport_rect().size.y)

func _on_ball_player_one_goal():
	match_data.player_one_score += 1
	set_to_start()

func _on_ball_player_two_goal():
	match_data.player_two_score += 1
	set_to_start()

# set players and ball to start
func set_to_start():
	ball.position = arena_center
	player.position = player_one_starting_pos
	player_two.position = player_two_starting_pos

func reset_scene():
	get_tree().reload_current_scene()
