tool
extends VBoxContainer

var ValueInspector = preload("res://addons/curve_edit/ValueInspect.tscn")

var pointOffset
var pointVal
var angleLeft
var angleRight

signal point_offset_changed
signal point_value_changed
signal angle_left_changed
signal angle_right_changed

func _init():
	setup_inspector()

func setup_inspector():
		
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
	pointOffset = ValueInspector.instance()
	pointOffset.setup("Offset")
	pointOffset.connect("value_changed", self, "point_offset_changed")
	
	pointVal = ValueInspector.instance()
	pointVal.setup("Value")
	pointVal.connect("value_changed", self, "point_value_changed")
	
	angleLeft = ValueInspector.instance()
	angleLeft.setup("Left (y/x) Ratio")
	angleLeft.connect("value_changed", self, "angle_left_changed")
	
	angleRight = ValueInspector.instance()
	angleRight.setup("Right (y/x) Ratio")
	angleRight.connect("value_changed", self, "angle_right_changed")
	
	add_child(pointOffset)
	add_child(pointVal)
	add_child(angleLeft)
	add_child(angleRight)
	

func point_offset_changed(value):
	emit_signal("point_offset_changed", value)
	
func point_value_changed(value):
	emit_signal("point_value_changed", value)
	
func angle_left_changed(value):
	emit_signal("angle_left_changed", value)
	
func angle_right_changed(value):
	emit_signal("angle_right_changed", value)

func set_point_vals(offset, value, left, right):
	pointOffset.set_value(offset)
	pointVal.set_value(value)
	angleLeft.set_value(left)
	angleRight.set_value(right)
	
# The only one affected by minmax changes is the y value
func set_min_max(minVal, maxVal):
	pointVal.set_min_max(minVal, maxVal)
	
func get_value():
	return pointVal.get_value()
	
func set_value(value):
	pointVal.set_value(value)
