tool
extends EditorPlugin

var plugin

func _enter_tree():
	# Curve2dInspect is a resource, so use new()
	plugin = preload("res://addons/curve_edit/CurveInspect.gd").new()
	add_inspector_plugin(plugin)


func _exit_tree():
	remove_inspector_plugin(plugin)
