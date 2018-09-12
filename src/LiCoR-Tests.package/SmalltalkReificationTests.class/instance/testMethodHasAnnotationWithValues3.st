method attributes
testMethodHasAnnotationWithValues3
	
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method1],?method methodHasAnnotation: #test: withValues: <itsatest>'
		description:
			'The method TestClassWithAttributedMethod>>method1 has an attribute test with value #itsatest'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],?method methodHasAnnotation: #test: withValues: <itsatest>,[?method selector = #method1]'
		description:
			'One of the methods with attribute test with value #itsatest is the method TestClassWithAttributedMethod>>method1 (tests leaving the ?method argument unbound)'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method1],not(?method methodHasAnnotation: ?key withValues: ?values,not(equals(?key,#test:)),not(equals(?values,<itsatest>)))'
		description:
			'The method TestClassWithAttributedMethod>>method1 doesnt have any attributes whose key is not #test or whose value is not #itsatest'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: #symbol: withValues: <asymbol>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute symbol -> #asymbol.'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: ?key withValues: <[''A String'']>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute with value ''A String'' '.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: #x:y: withValues: <1,2>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute key x:y: and values 1 and 2'.
	self processQuery:
			' if ?method isMethodInClass: [TestClassWithAttributedMethod],[?method selector = #method2],?method methodHasAnnotation: ?key withValues: <[#(1 #a ''test'')]>'
		description:
			'The method TestClassWithAttributedMethod>>method2 has an attribute with value #(1 a ''test'').'