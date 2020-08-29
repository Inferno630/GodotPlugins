extends EditorInspectorPlugin

var ControlVector = preload("res://addons/curve_edit/CurveControl.tscn")
var ControlValue = preload("res://addons/curve_edit/CurveValueControl.tscn")

var curveEdit = null

func can_handle(object):
	return (object is Curve2D) or (object is Curve3D) or (object is Curve) # handle Curve2D and Curve3D

# When first applying this plugin to a given object
func parse_begin(object):
	if (object is Curve2D) or (object is Curve3D):
		var curveVectorControl = ControlVector.instance()
		curveVectorControl.set_curve(object)
		add_custom_control(curveVectorControl)
		
	if object is Curve:
		curveEdit = object
		

func parse_end():
	if curveEdit is Curve:
		var curveValueControl = ControlValue.instance()
		curveValueControl.set_curve(curveEdit)
		add_custom_control(curveValueControl)
		curveEdit = null
