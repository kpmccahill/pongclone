extends Control

@onready var main_menu = $MainMenu
@onready var play_menu = $PlayMenu
@onready var options_menu = $OptionsMenu
@onready var audio_stream_player = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu.show()
	play_menu.hide()
	options_menu.hide()
	audio_stream_player.stream = load("res://assets/sounds/select.wav")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_select_sound():
	#audio_stream_player.stream = load("res://assets/sounds/select.wav")
	audio_stream_player.play()

func _on_quit_button_down():
	get_tree().quit()
	audio_stream_player.play()

func _on_play_button_down():
	#get_tree().change_scene_to_file("res://scenes/World.tscn")
	play_menu.show()
	main_menu.hide()
	audio_stream_player.play()

func _on_options_button_down():
	pass

func _on_player_vs_player_button_down():
	# get_tree().change_scene_to_file("res://scenes/World.tscn")
	audio_stream_player.play()										# okay so for these sounds, need to play them in singleton
	SceneSwitcher.switch_scene("res://scenes/World.tscn")
	

func _on_player_vs_computer_button_down():
	audio_stream_player.play()
	SceneSwitcher.versus_computer = true
	SceneSwitcher.switch_scene("res://scenes/World.tscn")

func _on_back_button_down():
	audio_stream_player.play()
	play_menu.hide()
	options_menu.hide()
	main_menu.show()

