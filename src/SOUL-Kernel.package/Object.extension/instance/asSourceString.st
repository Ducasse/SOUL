*SOUL-Kernel
asSourceString
	"This message gets send to an object if it is used inside a quotedcode. The result should be the textual representation of the object; as desired. Subclasses might 	want to override this message"

	
	| stream |
	stream := WriteStream on: String new.
	self printOn: stream.
	^stream contents