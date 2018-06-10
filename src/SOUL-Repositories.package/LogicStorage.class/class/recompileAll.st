compilation support
recompileAll
	
	self recompileSelectors.
	self subclasses do: [:subclass | subclass recompileAll]