private
slgTransformMain
	
	| literal newRule |
	literal := self conclusion printString.
	newRule := self
		generateRule: literal , ' if  slg(' , literal , ')'
		onError: [:a :b | self error: 'Something went terribly wrong!'].
	^newRule