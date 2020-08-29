# GodotPlugins

# CurveEdit
Install like any other Godot Plugin (copy folder into addons folder, then activate in Project Settings).

Adds the ability to set exact locations of points and their tangents for curves in the Inspector (for Curve, Curve2D, and Curve3D).

If you modify the curve itself, make sure to click the "Refresh" button to ensure the inspector data remains accurate.

Can add and remove points for Curve2D and Curve3D in the inspector. New points will appear at (0,0) and (0,0,0) respectively.
This does not apply to Curve.

Altering the Min and Max values of a Curve will clamp the existing values to the new Min and Max, so be careful using the slider.
This does not apply to Curve2D or Curve3D.
