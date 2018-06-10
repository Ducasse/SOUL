private
addToStack: aBoolean
	
	| newdfn |
	newdfn := SoulFactory addCallToStack: self.
	aBoolean
		ifTrue:
			["dfn notNil ifTrue: [
			this is probably a mistake, remove later when everything works
			^self halt.
		]."

			dfn := newdfn.
			plink := dfn]