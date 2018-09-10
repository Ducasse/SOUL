Public
outputClassResults
	
	| sortedAssociations |
	sortedAssociations := self totalsForClasses associations
		asSortedCollection: [:assoc1 :assoc2 | assoc2 < assoc2].
	sortedAssociations
		do:
			[:assoc | 
			self
				output: assoc key
				took: assoc value]