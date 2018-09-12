methods
isSourceCodeOfMethodXM2

"Retrieve the source code of a ?Method"

?Source isSourceCodeOfMethod: ?Method if 
	?Method isMethod,?Source equals: [?Method sourceCode]