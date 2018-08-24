extends Node2D

const SCREEN_WIDHT = 320
const SCREEN_HEIGHT = 180

var asteroid = preload("res://scenes/asteoid.tscn")
var score = 0

var is_game_over = false

var shake = 0

func _ready():
	randomize()
	get_node("player").connect("destroyed", self, "_on_player_destroyed")
	get_node("spawn_timer").connect("timeout", self, "_on_spawn_timer_timeout")
	
	$shake_timer.stop()
	#$spawn_timer.wait_time = .2

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://scenes/stage.tscn")


func _on_player_destroyed():
	get_node("ui/retry").show()
	is_game_over = true


func _on_spawn_timer_timeout():
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(SCREEN_WIDHT + 8, rand_range(40, SCREEN_HEIGHT - 10))
	asteroid_instance.connect("score", self, "_on_player_score")
	#asteroid_instance.move_speed += 50
	add_child(asteroid_instance)


func _on_player_score():
	score += 1
	#get_node("ui/score").text = "Score: " + str(score)
	get_node("ui/score").text = str(score)

func _on_shake_timer_timeout():
	if shake == 0:
		position.y += 2
		shake = 1
	elif shake == 1:
		position.y -= 2
		shake = 0
