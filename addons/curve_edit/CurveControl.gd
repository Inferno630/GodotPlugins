tool
extends VBoxContainer

var numPoints = 0

var CurvePointInspector = preload("res://addons/curve_edit/CurvePointInspector.tscn")
var numPointsInspector
var curveInspectorBoxes = []
var curveInspectors = []

var curve
var is2D = true

# Called when the position of a control point is changed	
func change_pos(vector, id):
	curve.set_point_position(id, vector)

# Called when the in-tangent of a control point is changed
func change_in(vector, id):
	curve.set_point_in(id, vector)
	
# Called when the out-tangent of a control point is changed
func change_out(vector, id):
	curve.set_point_out(id, vector)

# Set the curve that this controller manipulates, and generate the Inspector controls
func set_curve(newCurve):
	curve = newCurve
	is2D = curve is Curve2D # if this is a Curve2D, then we're working with 2D curves, otherwise, treat it as 3D
	
	clear_children() # Clear out the old UI elements (or they'll stack)
	
	create_refresh()
	
	create_num_point_inspector()
	
	# add inspector controls for all points the curve has
	for n in range(0, numPoints):
		add_point_inspector(n)
		

# Reapplies the curve so changes made in the editor window will be reflected in the inspector
func create_refresh():
	var b = Button.new()
	b.text = "Refresh"
	b.connect("pressed", self, "set_curve", [curve])
	add_child(b)

# Creates and attaches the Inspector element tracking the number of points
func create_num_point_inspector():
	
	var l = Label.new()
	l.text = "Number of Points"
	l.align = l.ALIGN_CENTER
	add_child(l)
	
	# Determine the number of points, then create a spinbox that will manipulate that value
	numPoints = curve.get_point_count() 
	
	numPointsInspector = SpinBox.new()
	numPointsInspector.value = numPoints
	numPointsInspector.max_value = 4096 # Max number of control points allowed by box
	numPointsInspector.connect("value_changed", self, "num_points_changed")
	add_child(numPointsInspector)

# Clears out the CurveControl's children.
func clear_children():
	for n in get_children():
		remove_child(n)
		n.queue_free()
		
	curveInspectorBoxes.clear()
	curveInspectors.clear()

# Create a new point on the curve, then add a new inspector for it
func add_new_point(index):
	if is2D:
		curve.add_point(Vector2(0,0)) # Add a new 2D point
	else:
		curve.add_point(Vector3(0,0,0)) # Add a new 3D point
	# Get the point count again (should be able to increment by 1, but this makes sure it isn't broken by a bug somewhere)
	numPoints = curve.get_point_count()
	numPointsInspector.value = numPoints
	add_point_inspector(index)

# Add a new curve point inspector (label and a CurvePointInspector), also hook them up
func add_point_inspector(index):
	# Create a horizontal box
	var box = HBoxContainer.new()
	
	# Make a button and put it in the box
	var button = Button.new()
	button.text = "Remove"
	button.connect("pressed", self, "remove_point", [index])
	box.add_child(button)
	
	# Make sure there's space between the coming label and the button
	box.add_constant_override("separation", 50)
	
	# Create the label and put it in the box
	var l = Label.new()
	l.text = "Point " + str(index)
	l.align = ALIGN_CENTER
	box.add_child(l)
	
	
	curveInspectorBoxes.append(box)
	add_child(box)
	
	# Add the CurvePointInspector
	var i = CurvePointInspector.instance()
	i.setup_inspector(is2D)
	i.set_point_vals(curve.get_point_position(index), curve.get_point_in(index), curve.get_point_out(index))
	i.connect("point_pos_changed", self, "change_pos", [index])
	i.connect("point_in_changed", self, "change_in", [index])
	i.connect("point_out_changed", self, "change_out", [index])
	curveInspectors.append(i)
	add_child(i)

# Remove a point at the given index
func remove_point(index):
	# Remove from the actual curve
	curve.remove_point(index)
	# Reset the UI (originally done with direct removal, now just wiping clean and rebuilding)
	# Much less efficient, but it's an editor tool no one will use, so...
	set_curve(curve)

# When the number of points changes, adjust the controls accordingly
func num_points_changed(value):
	if numPoints < value:
		for n in range(numPoints, value):
			add_new_point(n)	
	elif numPoints > value:
		for n in range(numPoints-1, value-1, -1):
			remove_point(n)
	# ignore if new value is the same
