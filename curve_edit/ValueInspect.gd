tool
extends Control


var title = "Value"

var value = 0

signal value_changed


func _ready():
	setup(title)

func setup(newTitle):
	title = newTitle
	$Label.text = title

func _on_vBox_value_changed(newValue):
	value = newValue
	emit_signal("value_changed", value)

func get_value():
	return value
	
func set_value(newValue):
	value = newValue
	$vBox.value = newValue
	
func set_min_max(newMin, newMax):
	$vBox.min_value = newMin
	$vBox.max_value = newMax
	$vBox.value = clamp(value, newMin, newMax)
