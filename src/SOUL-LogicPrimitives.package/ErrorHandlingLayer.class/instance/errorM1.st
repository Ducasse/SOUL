soul auto saved
errorM1

"Displays an error and immediately stops interpretation

SUnit test written (Roel, Jan 28, 2002)"

error(?errorString) if 
	[SoulRuntimeException signal: ('SOUL >> ' , ?errorString)]