extends Area2D

signal hit

export (int) var speed
var screenSize

func _ready():
	screenSize  = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false	

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		$Trail.emitting = true
		#if($AnimatedSprite.flip_v):
			#$Trail.rotation_degrees
	else:
		$AnimatedSprite.stop()
		$Trail.emitting = false
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)
	
	_handle_Animation(velocity)
	

func _handle_Animation(var velocity):
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.disabled = true
