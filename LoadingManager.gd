extends Node2D

var font = DynamicFont.new()

func _init():
	var data = DynamicFontData.new()
	data.font_path = "res://vcr_osd_mono.ttf"
	font.font_data = data
