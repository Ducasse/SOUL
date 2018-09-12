methods
selectorsOfClass: aClass whichRead: aVariableName
	| instVarIndex |
	instVarIndex := aClass instVarIndexFor: aVariableName ifAbsent: [^IdentitySet new].
	^ aClass selectors select:  [:sel | 
		((aClass methodDict at: sel)
			readsField: instVarIndex)]