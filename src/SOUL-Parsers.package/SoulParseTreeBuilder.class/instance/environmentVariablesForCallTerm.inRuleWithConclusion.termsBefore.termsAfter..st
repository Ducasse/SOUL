SLG
environmentVariablesForCallTerm: aCallOfTabledPredicate inRuleWithConclusion: aConclusion termsBefore: beforeCollection termsAfter: afterCollection
	"TODO: should be possible to capture the actual environment instead"

	
	| left right lfree rfree varsintersected |
	left := OrderedCollection new.
	left addAll: beforeCollection.
	left add: aConclusion.
	lfree := self variableNamesIn: (TermSequence terms: left).
	right := OrderedCollection new.
	right addAll: afterCollection.
	right add: aConclusion.
	right add: aCallOfTabledPredicate.
	rfree := self variableNamesIn: (TermSequence terms: right).
	varsintersected := (lfree select: [:v | rfree includes: v])
		asOrderedCollection.
	^ListTerm
		newFromCollection:
			(varsintersected collect: [:name | Variable name: name])