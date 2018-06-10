access
cut
	
	| frame |
	[frame := self pop.
	frame isEmpty
		ifFalse: [frame cuttop]
		ifTrue:
			[self push: frame.
			true]] whileFalse