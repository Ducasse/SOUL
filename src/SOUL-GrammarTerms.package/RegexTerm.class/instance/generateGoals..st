private
generateGoals: aCollection
	"returns a collection existing out of collections with newly added goals"

	
	| primitive allBefore allAfter newBefores newAfters first last |
	aCollection isEmpty ifTrue: [^nil].
	primitive := self detectRegexPrimitive: aCollection.
	primitive isNil
		ifTrue:
			["no more primitives to process, so we just create a goal"

			^self processCollection: aCollection]
		ifFalse:
			[allBefore := self allBefore: primitive in: aCollection.
			allAfter := self allAfter: primitive in: aCollection.
			newBefores := nil.
			newAfters := nil.
			allBefore isEmpty
				ifFalse: [newBefores := self processCollection: allBefore].
			newAfters := self
				perform: (RegexTerm keywords at: primitive functor smalltalkValue)
				withArguments: (Array with: primitive with: allAfter).
			newBefores isNil
				ifFalse:
					[first := newBefores at: 1.
					last := newBefores at: 2.
					newAfters isNil
						ifFalse:
							[self
								connect: last
								to: (newAfters at: 1)
								class: RegexTransition]].
			newBefores isNil ifTrue: [first := newAfters at: 1].
			last := newAfters at: 2].
	^Array with: first with: last