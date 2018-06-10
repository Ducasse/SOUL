update mechanism
notifyImplementationChange
	
	self storageDependents
		do:
			[:class | 
			class withAllSubclasses
				do:
					[:aclass | aclass allInstancesDo: [:e | e update: #changePredicate with: self]]]