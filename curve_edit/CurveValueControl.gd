tool
extends VBoxContainer

var numPoints = 0

var CurvePointInspector = preload("res://addons/curve_edit/CurveValueInspector.tscn")
var numPointsInspector
var curveInspectorLabels = []
var curveInspectors = []

var curve

# Called when the offset of a control point is changed	
func change_offset(offset, id):
	curve.set_point_offset(id, offset)

# Called when the value of a control point is changed
func change_value(value, id):
	curve.set_point_value(id, value)

# Called when the left angle of a control point is changed
func change_left_angle(angle, id):
	curve.set_point_left_tangent(id, angle)
	
# Called when the right angle of a control point is changed
func change_right_angle(angle, id):
	curve.set_point_right_tangent(id, angle)

# Set the curve that this controller manipulates, and generate the Inspector controls
func set_curve(newCurve):
	curve = newCurve
	
	clear_children() # Clear out the old UI elements (or they'll stack)
	
	if not curve.is_connected("range_changed", self, "change_range"):
		curve.connect("range_changed", self, "change_range")
	
	create_refresh()
	
	numPoints = curve.get_point_count()
	
	# add inspector controls for all points the curve has
	for n in range(0, numPoints):
		add_point_inspector(n)
		

# Reapplies the curve so changes made in the editor window will be reflected in the inspector
func create_refresh():
	var b = Button.new()
	b.text = "Refresh"
	b.connect("pressed", self, "set_curve", [curve])
	add_child(b)

# Clears out the CurveControl's children.
func clear_children():
	for n in get_children():
		remove_child(n)
		n.queue_free()
		
	curveInspectorLabels.clear()
	curveInspectors.clear()

# Add a new curve point inspector (label and a CurvePointInspector), also hook them up
func add_point_inspector(index):
	# Create the label and put it in the box
	var l = Label.new()
	l.text = "Point " + str(index)
	l.align = ALIGN_CENTER
	add_child(l)
	
	curveInspectorLabels.append(l)
	
	# Add the CurvePointInspector
	var i = CurvePointInspector.instance()
	i.set_point_vals(curve.get_point_position(index).x, curve.get_point_position(index).y, curve.get_point_left_tangent(index), curve.get_point_right_tangent(index))
	i.connect("point_offset_changed", self, "change_offset", [index])
	i.connect("point_value_changed", self, "change_value", [index])
	i.connect("angle_left_changed", self, "change_left_angle", [index])
	i.connect("angle_right_changed", self, "change_right_angle", [index])
	curveInspectors.append(i)
	add_child(i)

func change_range():
	for n in range(0, curveInspectors.size()):
		var i = curveInspectors[n] 
		i.set_value(curve.get_point_position(n).y)
		i.set_min_max(curve.min_value, curve.max_value)
		change_value(i.get_value(), n)
	set_curve(curve)
