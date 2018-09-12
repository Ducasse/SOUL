protocol2
method5
	"Added for the typing tests. Uses a mutator to set array to a new instance of SegmentedCollection. Sends messages to the accessor array to test #typeByAccessorSend."

	
	self array: SegmentedCollection new.
	self array at: 1 put: $b.
	^self array first