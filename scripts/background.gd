extends Sprite

const SCREEN_WIDHT = 320

var scroll_speed = 30

func _process(delta):
	position += Vector2(-scroll_speed * delta, 0)
	
	if position.x <= -SCREEN_WIDHT:
		position.x += SCREEN_WIDHT
