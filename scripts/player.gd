extends Area2D

const MOVE_SPEED = 150
const SCREEN_WIDTH = 320 - 50
const SCREEN_HEIGHT = 180 - 10

var shot_scene = preload("res://scenes/shot.tscn")
var explosion_scene = preload("res://scenes/explosion.tscn")

var can_shoot = true

signal destroyed

func _process(delta):
	
	var input_dir = Vector2() #Reseting input
	
	#Setting the spaceship direction
	if Input.is_key_pressed(KEY_UP): 
		input_dir.y -= 1 
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1
	
	#To limit the spaceship movimentation
	if position.x < 10:
		position.x = 10
	if position.x > SCREEN_WIDTH:
		position.x = SCREEN_WIDTH
	if position.y < 40:
		position.y =40
	if position.y > SCREEN_HEIGHT:
		position.y = SCREEN_HEIGHT
	
	position += (delta * MOVE_SPEED) * input_dir
	
	#Instancing the laser and limiting the amoung shoots
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var stage_node = get_parent()
		var shot_instance = shot_scene.instance()
		shot_instance.position = position + Vector2(14,0)
		stage_node.add_child(shot_instance)
		shot_instance = shot_scene.instance()
#		shot_instance.position = position + Vector2(9,-5)
#		stage_node.add_child(shot_instance)
#		shot_instance = shot_scene.instance()
#		shot_instance.position = position + Vector2(9,5)
#		stage_node.add_child(shot_instance)
		can_shoot = false
		$reload_timer.start()

func _on_player_area_entered(area):
	if area.is_in_group("asteroid"):
		emit_signal("destroyed")
		var stage_node = get_parent()
		var explosion_instance = explosion_scene.instance()
		explosion_instance.position = position
		stage_node.add_child(explosion_instance)
		queue_free()


func _on_reload_timer_timeout():
	can_shoot = true
