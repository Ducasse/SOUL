private
getResultVariable
	resultVar ifNil: [
		resultVar := self getVariables.		
	].
	^resultVar.
