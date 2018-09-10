soul -> smalltalk
testSoul2Smalltalk
	"These tests aren't very good because they still depend on the old symbiosis mechanism with the brackets .... it should perhaps become possible in the future to specify class names in SOUL directly without having to use the brackets"

	
	self processQuery: ' if [Array new] isEmpty' description:
			'Tests if a MessageTerm is correctly translated to a message'.
	self processQuery:
			' if [OrderedCollection new] asString = [''an OrderedCollection()'']'
		description:
			'Tests if a ResultMessageTerm without arguments is correctly translated to a message'.
	self processQuery: ' if [Array] with: 1 with: 2 = ?o,?o includes: 1'
		description:
			'Tests if a ResultMessageTerm with arguments is correctly translated to a message'.
	self processQuery:
			' if equals(?x,[OrderedCollection with: 1 with: 2 with: 3]),findall(?r,?x yourself = ?r,<1,2,3>)'
		description:
			'Tests wether results of messages to Smalltalk that are contained in an OrderedCollection are unwrapped and returned as seperate results.'.
	self processQuery:
			' if equals(?x,[OrderedCollection with: 1 with: 2 with: 3]),?x yourself = ?r,equals(?r,3),findall(?s,?x yourself = ?s,<1,2,3>)'
		description:
			'Tests wether the collections returned from messages to Smalltalk are not modified due to backtracking.'