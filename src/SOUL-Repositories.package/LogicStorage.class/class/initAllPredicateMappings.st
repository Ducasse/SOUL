initialize
initAllPredicateMappings
	"recursively construct the table of selector -> predicates mappings. this is used by the clause browser"

	
	self initPredicateMappings.
	self subclasses do: [:subclass | subclass initAllPredicateMappings]