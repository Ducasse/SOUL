visitor - double dispatching
visitSoulVariable: aSoulVariable
	
	dict
		at: aSoulVariable name
		put: (SoulFactory current makeVariable name: aSoulVariable name)