visiting terms
smalltalkTermVisit: anSTTerm
	
	| variables |
	variables := anSTTerm variables.
	(1 to: variables size) do: [:index | doBlock value: (variables at: index)]