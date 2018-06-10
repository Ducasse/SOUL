DCG
buildTerminalbody: aBody on: aStream
	
	aStream write: 'equals(?tokens1,'.
	aBody terms first printOn: aStream.
	aStream skip: -1.
	aStream write: ' | ?tokens2>)'