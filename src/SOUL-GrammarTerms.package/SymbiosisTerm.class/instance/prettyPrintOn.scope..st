printing
prettyPrintOn: aStream scope: id
	
	| inVar attribute |

	inVar := false.
	attribute := TextColor black.
	source
		do:
			[:char | 
			"this is ugly... but at least it works fast :-)"

			inVar
				ifTrue:
					[char isAlphaNumeric | char isSymbol
						ifFalse:
							[inVar := false.
							attribute := TextColor black.]].
			char = $? | (char = $&)
				ifTrue:
					[attribute := TextColor color: (Color r:0 g:0 b:256).
					inVar := true].
			aStream withAttribute: attribute do:[aStream write: char]].
