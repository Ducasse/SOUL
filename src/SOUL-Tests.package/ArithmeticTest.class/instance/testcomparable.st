comparison
testcomparable
	"comparable/2"

	
	self processQuery: ' if fails(comparable([Object],[1]))' description:
			'Is Object not comparable with a number ?'.
	self processQuery: ' if succeeds(comparable([2],[1]))' description:
			'Is an integer comparable with another integer ?'.
	self processQuery: ' if succeeds(comparable([2.0],[1]))' description:
			'Is an integer comparable with a real ?'