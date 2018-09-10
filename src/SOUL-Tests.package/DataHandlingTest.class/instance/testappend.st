list handling
testappend
	"self run:#testappend"

	
	self processQuery:
			' if succeeds(and(append(<[1],[2],[3]>,<[4],[5],[6]>,?r),equals(?r,<[1],[2],[3],[4],[5],[6]>)))'
		description: 'Can we append two simple lists?'.
	self processQuery:
			' if succeeds(append(<[1],[2],[3]>,<[4],[5],[6]>,<[1],[2],[3],[4],[5],[6]>))'
		description: 'Is the append of two simple lists the appended list?'.
	self processQuery:
			' if succeeds(and(append(<[1],[2],[3]>,?S,<[1],[2],[3],[4],[5],[6]>),equals(?S,<[4],[5],[6]>)))'
		description:
			'Can we deduce what second string needs be appended to a first one to get a certain result?'.
	self processQuery:
			' if succeeds(and(append(?F,<[3],[4],[5],[6]>,<[1],[2],[3],[4],[5],[6]>),equals(?S,<[1],[2]>)))'
		description:
			'Can we deduce what first string needs be appended to a second one to get a certain result?'.
	self processQuery:
			' if findall(?F,append(?F,?S,<[1],[2],[3],[4]>),<<>,<[1]>,<[1],[2]>,<[1],[2],[3]>,<[1],[2],[3],[4]>>)'
		description:
			'What possible strings can be appended to get a certain result string?'