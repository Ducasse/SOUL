method attributes
isSourceCodeOfMethodXM2

"Retrieve the ?Source of a ?Method"

?Source isSourceCodeOfMethod: ?Method if 
	?Method isMethod,?Source equals: [?Method sourceCode]