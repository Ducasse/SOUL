private
processNot: notTerm remainingConditions: aCollection
	
	| end notGoal newGoals remainingGoals fail |
	newGoals := self generateGoal: notTerm termSequence terms.
	newGoals ifNil: [self error: 'not term without any goals'].
	notGoal := self generateGoal: OrderedCollection new.
	self
		connect: notGoal
		to: (newGoals at: 1)
		class: RegexEpsilonTransition.
	remainingGoals := self generateGoals: aCollection.
	fail := self generateFailGoal.	"if newGoals succeeds we have to fail"

	self
		connect: (newGoals at: 2)
		to: fail
		class: RegexCuttedEpsilonTransition.
	remainingGoals isNil
		ifFalse:
			[self
				connect: notGoal
				to: (remainingGoals at: 1)
				class: RegexCuttedEpsilonTransition.
			end := remainingGoals at: 2]
		ifTrue:
			["we have to create a success-goal"

			end := self
				generateGoal:
					(SoulFactory current makeParser
						parse: 'if [ true ]'
						onError: [:a :b | self error: 'parse error in generated regexrule'])
						condition terms.
			self connect: notGoal to: end class: RegexCuttedEpsilonTransition].
	^Array with: notGoal with: end