visitor - double dispatching
visitDelayedSoulVariable: aSoulVariable
	
	dict
		at: aSoulVariable name
		put: (SoulFactory current makeDelayedVariable name: aSoulVariable name)