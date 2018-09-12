traversal
complexWith: modifiers and: bindings and: specificImports and: generalImports
	
	| key bind aName |
	aName := 'dummy' , 'concatenation' , $a printString.
	(modifiers hasVisited: self) ifTrue: [^nil].
	key := self asKey: aName.
	bind := bindings lookup: key.
	bind == nil ifFalse: [^bind].
	bind := modifiers substituteFor: self localBindingFor: key.
	bind == nil ifFalse: [^bind].
	1
		to: specificImports size
		do:
			[:imp | 
			bind := (specificImports at: imp) bindingFor: key modifiers: modifiers.
			bind == nil ifFalse: [^bind]].
	bind := nil.
	generalImports size > 0
		ifTrue:
			[modifiers
				forNames: self
				do:
					[1
						to: generalImports size
						do:
							[:imp | 
							| b |
							b := (generalImports at: imp) bindingFor: key modifiers: modifiers.
							b == nil
								ifFalse:
									[(bind == nil or: [bind == b])
										ifTrue: [bind := b]
										ifFalse: [bind := self conflictingImports: key firstFound: bind]]]]].
	^bind