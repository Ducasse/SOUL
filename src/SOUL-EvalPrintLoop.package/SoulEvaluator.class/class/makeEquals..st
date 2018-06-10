private
makeEquals: aCollection
	
	| result var val terms equals |
	result := OrderedCollection new.
	aCollection
		do:
			[:varvalue | 
			| functorname |
			var := SoulFactory current makeVariable name: varvalue key asString.	"WARNING: the implementation of this method changed to invoke the parser because a bug occurred when the values are soul terms extracted from other terms. Since these will again be passing through the variable indexer and break the entire variable-indexing mechanism. Passing everything through the parser ensures making a unique copy that can be cleaned on its own"

			((varvalue value isKindOf: AbstractTerm)
				and: [(varvalue value isKindOf: UppedObject) not])
				ifTrue:
					[| copying "[val := (SoulParser parse: varvalue value displayString) terms first
						conclusion]"
 |
					copying := CopyingVisitor new.
					val := varvalue value accept: copying]
				ifFalse: [val := varvalue value soulUp].
			functorname := (varvalue value isMemberOf: OrderedCollection)
				ifTrue: [#member]
				ifFalse: [#equals].
			terms := OrderedCollection new.
			terms add: var.
			terms add: val.
			equals := SoulFactory current makeCompound
				functor: (Constant name: functorname)
				termSequence: (TermSequence terms: terms).
			result add: equals].
	^result