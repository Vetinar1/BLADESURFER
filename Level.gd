extends Node2D

var live_pieces = []
var pieces

func _ready():
	# load level pieces
	var sp1 = preload("res://StraightPiece1.tscn")
	var sp2 = preload("res://StraightPiece2.tscn")
	
	pieces = [sp1, sp2]
	
	# load first
	pieces.shuffle()
	
	live_pieces.append(pieces[0].instance())
	add_child(live_pieces[0])
	
	
	
func load_new():
	print("loading new")
	while pieces[0] == live_pieces[-1]:
		pieces.shuffle()
		
	live_pieces.append(pieces[0].instance())
	live_pieces[-1].position += live_pieces[-2].get_node("Exit").position + live_pieces[-2].position
	call_deferred("add_child", live_pieces[-1])
	

func unload_old():
	print("Unloading old")
	
	if len(live_pieces) > 4:
		live_pieces[0].queue_free()
		live_pieces.remove(0)
	
	print("Loaded: ", len(live_pieces))

