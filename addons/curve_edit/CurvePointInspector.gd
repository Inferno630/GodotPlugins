tool
extends VBoxContainer

var Vector2Inspector = preload("res://addons/curve_edit/Vector2Inspect.tscn")
var Vector3Inspector = preload("res://addons/curve_edit/Vector3Inspect.tscn")
var TiltInspector = preload("res://addons/curve_edit/TiltInspect.tscn")
var CurrentVectorInspector = Vector2Inspector

var pointPos
var pointIn
var pointOut
var pointTilt

signal point_pos_changed
signal point_in_changed
signal point_out_changed
signal point_tilt_changed

func _init():
	setup_inspector(false)

func setup_inspector(is2D):
	if is2D:
		CurrentVectorInspector = Vector2Inspector
	else:
		CurrentVectorInspector = Vector3Inspector
		
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
	pointPos = CurrentVectorInspector.instance()
	pointPos.setup("Position")
	pointPos.connect("vector_changed", self, "point_pos_changed")
	
	pointIn = CurrentVectorInspector.instance()
	pointIn.setup("Tangent In")
	pointIn.connect("vector_changed", self, "point_in_changed")
	
	pointOut = CurrentVectorInspector.instance()
	pointOut.setup("Tangent Out")
	pointOut.connect("vector_changed", self, "point_out_changed")
	
	add_child(pointPos)
	add_child(pointIn)
	add_child(pointOut)
	if !is2D:
		pointTilt = TiltInspector.instance()
		pointTilt.connect("tilt_changed", self, "point_tilt_changed")
		add_child(pointTilt)

func point_pos_changed(vector):
	emit_signal("point_pos_changed", vector)
	
func point_in_changed(vector):
	emit_signal("point_in_changed", vector)
	
func point_out_changed(vector):
	emit_signal("point_out_changed", vector)

func point_tilt_changed(tilt):
	emit_signal("point_tilt_changed", tilt)

func set_3D_point_vals(posVec, inVec, outVec, tilt):
	pointPos.set_vector(posVec)
	pointIn.set_vector(inVec)
	pointOut.set_vector(outVec)
	pointTilt.set_tilt(tilt)

func set_2D_point_vals(posVec, inVec, outVec):
	pointPos.set_vector(posVec)
	pointIn.set_vector(inVec)
	pointOut.set_vector(outVec)
#	pointTilt.set_tilt(tilt)
