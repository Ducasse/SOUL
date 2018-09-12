naming
testIsMethodWithName2
	"self run: #testmethodWithName2"

	
	self processQuery:
			' if succeeds(and(?method isMethodInClass: [TestClass3],?method isMethodWithName: [#anAbstractMethod]))'
		description:
			'The name of TestClass3>>#anAbstractMethod is #anAbstractMethod.'