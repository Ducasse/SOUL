compilation support
recompileSelectors
	
	self selectors do: [:selector | self recompile: selector]