list handling
testdeepflatten
	"deepflatten/2"

	
	self processQuery:
			' if succeeds(deepflatten(<<[1],<[2]>,[3]>,<<<[4]>,[5]>,[6]>>,<[1],[2],[3],[4],[5],[6]>))'
		description:
			'Can we test whether a shallow list is a flattened version of a deeply nested list?'.
	self processQuery:
			' if succeeds(and(deepflatten(<<[1],[2],[3]>,<[4],[5],[6]>>,?flatlist),equals(?flatlist,<[1],[2],[3],[4],[5],[6]>)))'
		description: 'Can we flatten a deeply nested list into a shallow one?'.
	self processQuery:
			' if succeeds(and(deepflatten(<<[1],<hallo,aloha>,[2],<>,[3]>,<[4],<>,[5],[6]>>,?flatlist),equals(?flatlist,<[1],hallo,aloha,[2],[3],[4],[5],[6]>)))'
		description:
			'Can we flatten a deeply nested list that contains empty sublists into a shallow one?'.
	self processQuery: ' if fails(deepflatten(?x,<a,b,c,d>))' description:
			'Does deepflatten/2 fail when the first argument is variable?'