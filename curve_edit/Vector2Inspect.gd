tool
extends Control


var title = "Vector"

var vector = Vector2(0,0)

signal vector_changed


func _ready():
	setup(title)

func setup(newTitle):
	title = newTitle
	$Label.text = title

func _on_xBox_value_changed(value):
	vector.x = value
	emit_signal("vector_changed", vector)


func _on_yBox_value_changed(value):
	vector.y = value
	emit_signal("vector_changed", vector)

func get_vector():
	return vector
	
func set_vector(newVector):
	vector = newVector
	$valueContain/xContain/xBox.value = vector.x
	$valueContain/yContain/yBox.value = vector.y
