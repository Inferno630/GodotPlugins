# GodotPlugins

# CurveEdit
Adds the ability to set exact locations of points and their tangents for curves in the Inspector (for Curve, Curve2D, and Curve3D).

If you modify the curve itself, make sure to click the "Refresh" button to ensure the inspector data remains accurate.

Can add and remove points for Curve2D and Curve3D in the inspector. New points will appear at (0,0) and (0,0,0) respectively.
This does not apply to Curve.

Altering the Min and Max values of a Curve will clamp the existing values to the new Min and Max, so be careful using the slider.
This does not apply to Curve2D or Curve3D.

# Installation
Theoretically, follow this https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html
Though it doesn't seem to actually find the subfolders?

Otherwise, go to Project->Project Settings->Plugins (tab)->Create <br/>
And fill in as follows: <br/>
Plugin Name: CurveEdit <br/>
Subfolder: curve_edit <br/>
Author: Inferno <br/>
Version: 1.0 <br/>
Script Name: CurveEdit.gd <br/>

Then when the engine makes an actual addons/curve_edit folder, copy the files from the downloaded plugin's curve_edit folder into the project via the system's file browser.
Lastly, go to Project->Project->Settings->Plugins (tab) and Enable CurveEdit.