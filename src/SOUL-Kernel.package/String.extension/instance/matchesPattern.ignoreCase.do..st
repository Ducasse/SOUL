*SOUL-Kernel
matchesPattern: pattern ignoreCase: ignoreCase do: aBlock
	"Answer whether the receiver matches the pattern.  Matching
	includes upper/lower case differences if ignoreCase is false.  Where the
	pattern contains #, the receiver may contain any single character.  Where
	the pattern contains *, the receiver may contain any sequence of characters.
	If aBlock is not nil then before the receiver answers true for the matching case,
	 the block will be evaluated with the start and stop index for the runs matching
	a # or a *.  Note that the block may be evaluated even if the ultimate answer
	is false."

	"'hello.goodby' matchesPattern: '*.*' ignoreCase: false do: nil."

	"| tmp str |
	tmp := OrderedCollection new.
	str := 'hello.goodby'.
	str matchesPattern: '*.*' ignoreCase: false do: [:start :stop | tmp add: (str copyFrom: start to: stop)].
	tmp"
	
	| stringSize stringIndex patternSize patternIndex p t patternStartScan stringStartScan singleMatches |

	stringSize := self size. 
	stringIndex := 1.
	patternSize := pattern size.
	patternIndex := 1.

	" patternStartScan = patternIndex of the most recent * + 1.
	stringStartScan = stringIndex when we saw the *,
		or nil if we haven't seen any * yet.
	singleMatches = stringIndex values corresponding to #s in the pattern
		since the last *, or nil if no block. "

	stringStartScan := nil.
	singleMatches := aBlock == nil
		ifTrue: [nil]
		ifFalse: [OrderedCollection new].
	[patternIndex <= patternSize]
		whileTrue: 
			[p := pattern at: patternIndex.
			patternIndex := patternIndex + 1.
			p == $*
				ifTrue: 
					[" We found a successful match after the last *,
					if any.  Give it, and any subsequent # matches, to the block. "
					aBlock == nil
						ifFalse:
							[stringStartScan == nil
								ifFalse:
									[aBlock value: stringStartScan value: stringIndex + patternStartScan - patternIndex].
							singleMatches do: [:index | aBlock value: index value: index]].
					patternIndex > patternSize 
						ifTrue:
							[" We have a * as the last element of the pattern.
							Give the block the entire rest of the string. "
							aBlock == nil ifFalse: [aBlock value: stringIndex value: stringSize].
							^true].
					stringStartScan := stringIndex.
					patternStartScan := patternIndex.
					singleMatches == nil ifFalse: [singleMatches setIndices]]
				ifFalse: 
					[stringIndex > stringSize ifTrue: [^false].
					t := self at: stringIndex.
					stringIndex := stringIndex + 1.
					(t == p or: [p == $# or: [ignoreCase and: [t asUppercase == p asUppercase]]])
						ifTrue:
							[(patternIndex > patternSize and: [stringIndex <= stringSize])
								ifTrue:
									[" We ran off the end of the pattern.
									Treat like a non-match (see below). "
									stringStartScan == nil ifTrue: [^false].
									stringIndex := stringIndex + patternStartScan - patternIndex + 1.
									patternIndex := patternStartScan.
									singleMatches == nil ifFalse: [singleMatches setIndices]]
								ifFalse:
									[(p == $# and: [singleMatches notNil])
										ifTrue: [singleMatches addLast: stringIndex - 1]]]
						ifFalse:
							[" We hit a non-match while scanning.
							Back up the string to one character after
							the beginning of the current partial match,
							and the pattern to just after the last *. "
							stringStartScan == nil ifTrue: [^false].  "no * yet, match fails"
							stringIndex := stringIndex + patternStartScan - patternIndex + 1.
							patternIndex := patternStartScan.
							singleMatches == nil ifFalse: [singleMatches setIndices]]]].
	stringIndex <= stringSize
		ifTrue:
			[" We didn't match the whole string: report failure. "
			^false].
	" Give the last match(es) to the block. "
	aBlock == nil
		ifFalse:
			[stringStartScan == nil
				ifFalse:
					[aBlock value: stringStartScan value: stringIndex + patternStartScan - patternIndex - 1].
			singleMatches do: [:index | aBlock value: index value: index]].
	^true