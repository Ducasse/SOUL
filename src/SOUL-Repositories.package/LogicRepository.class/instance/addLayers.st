add/del - from storage
addLayers
	
	| instance program |
	fromLayers
		do:
			[:aLayer | 
			instance := aLayer new.
			aLayer selectors
				do:
					[:sel | 
					program := instance perform: sel.
					self addClauses: program clauses]]