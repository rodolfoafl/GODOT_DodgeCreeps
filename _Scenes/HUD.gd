extends CanvasLayer

signal startGame

func _show_Message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func _show_game_over():
	_show_Message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	
func _update_score(score):
	$ScoreLabel.text = str(score)



func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("startGame")
