Private
output: aString took: number
	"Output the given string and the number (indicating the time it took for the result to obtain)"

	
	(self outputStream)
		nextPutAll: aString;
		tab;
		nextPutAll: 'took: ';
		tab;
		print: number;
		cr