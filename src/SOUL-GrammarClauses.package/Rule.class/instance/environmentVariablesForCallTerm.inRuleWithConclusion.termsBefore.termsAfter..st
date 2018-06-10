private
environmentVariablesForCallTerm: aCallOfTabledPredicate inRuleWithConclusion: aConclusion termsBefore: beforeCollection termsAfter: afterCollection
	"taken from the paper: all variables in the head must be passed to the cont of Li
	in addition all vars that occur BOTH in L1..Li-1 and Li..Ln must be passed to cont Li
	aCallOfTabledPredicate is Li, aConclusion is the conclusion of the rule we are transforming"

	"TODO: should be possible to capture the actual environment instead (c) Coen"

	
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