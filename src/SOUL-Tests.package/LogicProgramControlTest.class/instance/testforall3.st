sets of solutions
testforall3
	"self run:#testforall3"

	"forall/3"

	
	self processQuery:
			' if succeeds(and(forall(member(?e,<[1],[2],[3]>),equals(?e,[2]),?L),length(?L,2)))'
		description:
			'forall/3 is not lazy and produces a list containing as many elements as there are failures'.
	self processQuery:
			' if succeeds(and(forall(member(?e,<[1],[2],[3]>),equals(?e,[2]),?L),equals(?L,<equals([1],[2]),equals([3],[2])>)))'
		description: 'forall/3 correctly produces all failures'.
	self processQuery:
			' if succeeds(forall(member(?e,<[1],[2],[3]>),integer(?e),<>))'
		description: 'forall/3 produces an empty list when all test succeed'