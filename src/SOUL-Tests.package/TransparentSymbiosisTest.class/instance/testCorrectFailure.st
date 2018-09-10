smalltalk -> soul
testCorrectFailure
	"Tests whether it doesn't get into an endless loop when neither rule nor method exists. Placed seperately just in case it *does* loop so you know what's wrong."

	
	self
		should:
			[TransparentSymbiosisTestClass new supercalifragilisticexpialidocious]
		raise: Exception