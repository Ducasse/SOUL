private
equivalenceStringFor: aTerm
	
	| string last first intervals |
	string := aTerm asString.
	intervals := OrderedCollection new.
	last := 0.
	[first := string
		findFirst: [:char | char = $?]
		startingAt: last + 1.
	first ~= 0]
		whileTrue:
			[last := (string
				findFirst: [:char | char isAlphaNumeric not]
				startingAt: first + 1) - 1.
			last < 0 ifTrue: [last := string size].
			intervals add: (first + 1 to: last)].
	intervals do: [:interval | interval do: [:i | string at: i put: $*]].
	^string copyWithout: $*