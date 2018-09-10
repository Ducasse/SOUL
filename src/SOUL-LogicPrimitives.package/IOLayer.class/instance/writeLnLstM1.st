soul auto saved
writeLnLstM1

"tested on 29/08/2001

writeLnLst(?List) writes each of the elements of a list on the Transcript,
	 each one separated by a carriage return."

writeLnLst(?List) if 
	foreach(?List,writeLn)