Examples
fullyTimeSuiteOnFileNamed: aFileNameString
	"Fully time me, and output the results on a file with the given name."

	
	| stream |
	stream := aFileNameString asFilename writeStream.
	[self fullyTimeSuiteOnStream: stream] ensure: [stream close]