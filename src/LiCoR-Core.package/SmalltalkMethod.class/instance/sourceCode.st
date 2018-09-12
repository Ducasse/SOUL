information extraction
sourceCode
	| source |
	source := compiledMethod sourceCode.
	source ifNil: [ source := compiledMethod decompiledSource ].
	^ source