private
processCollection: aCollection
	
	| first prev curr |
	prev := self generateGoal: (OrderedCollection with: aCollection first).
	first := prev.
	(aCollection allButFirst: 1)
		do:
			[:term | 
			curr := self generateGoal: (OrderedCollection with: term).
			self connect: prev to: curr class: RegexTransition.
			prev := curr].
	^Array with: first with: prev