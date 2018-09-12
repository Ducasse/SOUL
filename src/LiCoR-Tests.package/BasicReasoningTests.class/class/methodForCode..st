private
methodForCode: aString
	"Take aString, and return a method for that string. This is used for tests that need to generate methods on the fly. Otherwise those methods have to be stored on test classes all the time, which is not always desired."

	
	^Compiler new
		compile: aString
		in: nil
		allowReceiver: true
		class: nil class
		environment: Smalltalk
		noPattern: false
		notifying: nil
		ifFail: [^nil]