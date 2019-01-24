extends RigidBody2D

export(int) var minSpeed
export(int) var maxSpeed
var mobTypes = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mobTypes[randi() % mobTypes.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
