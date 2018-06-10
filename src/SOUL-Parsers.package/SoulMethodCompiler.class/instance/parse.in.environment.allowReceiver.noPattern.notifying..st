public accessing
parse: textOrStream in: aClass environment: env allowReceiver: allowSelf noPattern: noPattern notifying: req
	"Compile the incoming text and answer with the resulting parse tree.
	This is the only public message that saves the source map
	and the comments.  If the requestor is nil,
	warning messages (as opposed to outright errors)
	are silently discarded."

	
	^Compiler new parse: textOrStream in: aClass environment: env
		allowReceiver: allowSelf noPattern: noPattern notifying: req