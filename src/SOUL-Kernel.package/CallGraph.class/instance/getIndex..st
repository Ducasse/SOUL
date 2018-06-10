private
getIndex: termString
	
	^nodeMapping
		at: termString
		ifAbsent: [nil]