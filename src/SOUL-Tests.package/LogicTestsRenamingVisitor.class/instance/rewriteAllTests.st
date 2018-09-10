rewriting
rewriteAllTests
	
	LogicTests allSubclasses
		do:
			[:testclass | 
			testclass selectors
				do:
					[:selector | 
					Transcript
						show: testclass name , '>>' , selector asString;
						cr.
					self rewrite: selector in: testclass]]