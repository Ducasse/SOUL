DCG
buildNormalbody: aBody on: aStream
	
	| counter |
	counter := 1.
	aBody terms
		do:
			[:aTerm | 
			aTerm printOn: aStream.
			aStream
				skip: -1;
				write: ',?tokens' , counter asString.
			counter := counter + 1.
			aStream write: ',?tokens' , counter asString , ')']
		separatedBy: [aStream write: ',']