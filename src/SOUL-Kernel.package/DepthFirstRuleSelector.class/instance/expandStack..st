private
expandStack: aFrameCollection
	"expand the stack with new frames"

	
	aFrameCollection reverseDo: [:aFrame | callstack push: aFrame]