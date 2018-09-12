smalltalk method term
testCreation
	"self run: #testCreation"

	"self debug: #testCreation"

	
	| aStMethodTerm |
	aStMethodTerm := self methodForClass: AbstractTerm selector: #printOn:.
	self assert: aStMethodTerm fromClass = AbstractTerm.
	self assert: aStMethodTerm selector = #printOn: