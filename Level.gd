extends Node2D

var live_pieces = []
var pieces

var count = 0

func _ready():
	# load level pieces
#	var sp1 = preload("res://StraightPiece1.tscn")
	var sp2 = preload("res://StraightPiece2.tscn")
	var lp1 = preload("res://LongPiece1.tscn")
	var lp2 = preload("res://LongPiece2.tscn")
	var lp3 = preload("res://LongPiece3.tscn")
	var wp1 = preload("res://WidePiece1.tscn")
	var zp1 = preload("res://Zpiece1.tscn")
	var pp1 = preload("res://PipePiece1.tscn")
	var bp1 = preload("res://BonusPiece.tscn")
	
	pieces = [sp2, lp1, wp1, zp1, pp1, lp2, lp3, bp1]
	
	# load first
	pieces.shuffle()
	
	live_pieces.append(pieces[0].instance())
	add_child(live_pieces[0])
	
	
	
func load_new():
	count += 1
	pieces.shuffle()
	#live_pieces.append()
	var new_piece = pieces[0].instance()
	new_piece.name = "piece" + str(count)
	call_deferred("add_child", new_piece)
	live_pieces.append(new_piece)
	live_pieces[-1].position += live_pieces[-2].get_node("Exit").position + live_pieces[-2].position
	

func unload_old():
	if len(live_pieces) > 4:
		live_pieces[0].queue_free()
		live_pieces.remove(0)
	
