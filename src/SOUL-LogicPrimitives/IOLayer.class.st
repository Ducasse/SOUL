Class {
	#name : #IOLayer,
	#superclass : #LogicPrimitives,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'soul auto saved' }
IOLayer >> newlineM1 [

"tested on 08/07/2001

newline/0 takes the cursor to the next line on the Transcript.
	It takes a dummy argument because PROLOG does not allow 0-ary predicates."

newline(?) if 
	[Transcript cr.
true]
]

{ #category : #'soul auto saved' }
IOLayer >> writeLnLstM1 [

"tested on 29/08/2001

writeLnLst(?List) writes each of the elements of a list on the Transcript,
	 each one separated by a carriage return."

writeLnLst(?List) if 
	foreach(?List,writeLn)
]

{ #category : #'soul auto saved' }
IOLayer >> writeLnM1 [

"tested on 08/07/2001

writeLn(?Something) writes the string representation of ?Something on
	 the Transcript, followed by a carriage return."

writeLn(?Something) if 
	write(?Something),newline(?)
]

{ #category : #'soul auto saved' }
IOLayer >> writeLstLnM1 [

"tested on 29/08/2001

writeLstLn(?List) writes each of the elements of a list on the Transcript, one after the other,
	 and then go to a new line."

writeLstLn(?List) if 
	writeLst(?List),newline(?)
]

{ #category : #'soul auto saved' }
IOLayer >> writeLstM1 [

"tested on 29/08/2001

writeLst(?List) writes each of the elements of a list on the Transcript, one after the other."

writeLst(?List) if 
	foreach(?List,write)
]

{ #category : #'soul auto saved' }
IOLayer >> writeM1 [

"tested on 08/07/2001

write(?Something) writes the string representation of ?Something on the Transcript."

write(?Something) if 
	[Transcript show: ?Something asString.
true]
]
