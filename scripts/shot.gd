extends Area2D

const SCREEN_WIDHT = 320 #Max Widht
const MOVE_SPEED = 500

func _ready():
	pass

func _process(delta):
	
	position += Vector2(MOVE_SPEED * delta, 0) #Forward forever 
	
	if position.x >= SCREEN_WIDHT + 8:
		queue_free()


func _on_shot_area_entered(area):
	if area.is_in_group("asteroid"):
		queue_free()
