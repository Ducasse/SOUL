parser-printer
testConversion
	
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: #bar) smalltalkBlockString = 'bar'.
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: 'bar') smalltalkBlockString =
					'bar'.
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: '#bar') smalltalkBlockString =
					'#bar'.
	self
		assert:
			(SoulParseTreeBuilder new buildConstant: #'instance creation')
				smalltalkBlockString = 'instance creation'