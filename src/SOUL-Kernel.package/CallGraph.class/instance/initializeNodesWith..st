private
initializeNodesWith: anInteger
	
	nodes := Array new: anInteger.
	1
		to: anInteger
		do:
			[:x | 
			nodes
				at: x
				put: (Array new: anInteger)]