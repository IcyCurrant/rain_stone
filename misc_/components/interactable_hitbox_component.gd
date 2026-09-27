extends Area2D

var is_overlapping : bool = false
signal key_pressed

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		key_pressed.emit()
		print("true")

# body entered/exited
func _on_body_entered(body: Node2D) -> bool:
	if body.is_in_group("player"):
		is_overlapping = true
		print(is_overlapping)
	return is_overlapping
func _on_body_exited(body: Node2D) -> bool:
	if body.is_in_group("player"):
		is_overlapping = false
		print(is_overlapping)
	return is_overlapping
