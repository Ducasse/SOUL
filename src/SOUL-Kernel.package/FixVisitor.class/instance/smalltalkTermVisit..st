visiting terms
smalltalkTermVisit: anSTTerm
	
	| vars |
	vars := anSTTerm variables.
	(1 to: vars size) do: [:index | (vars at: index) accept: self]