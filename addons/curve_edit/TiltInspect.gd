tool
extends Control


#var title = "Vector"

#var vector = Vector3(0,0,0)
var tilt = float(0)

#signal vector_changed
signal tilt_changed


#func _ready():
#	setup(title)


#func setup(newTitle):
#	title = newTitle
#	$Label.text = title

#func _on_xBox_value_changed(value):
#	vector.x = value
#	emit_signal("vector_changed", vector)

#func _on_yBox_value_changed(value):
#	vector.y = value
#	emit_signal("vector_changed", vector)
#
#func _on_zBox_value_changed(value):
#	vector.z = value
#	emit_signal("vector_changed", vector)

func _on_tiltBox_value_changed(value):
	tilt = value
	emit_signal("tilt_changed", tilt)

#func get_vector():
#	return vector

func get_tilt():
	return tilt
	
#func set_vector(newVector):
#	vector = newVector
#	$valueContain/xContain/xBox.value = vector.x
#	$valueContain/yContain/yBox.value = vector.y
#	$valueContain/zContain/zBox.value = vector.z

func set_tilt(newTilt):
	tilt = newTilt
	$valueContain/tiltContain/tiltBox.value = tilt
