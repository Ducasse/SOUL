reification
transitiveLookupIn: anEnv startAt: anIndex
	"This method should be implemented by the subclasses and return a fully ground term representation for this term by walking the environment when 	necessary and constructing a new term for the representation as a result"

	
	^self subclassResponsibility