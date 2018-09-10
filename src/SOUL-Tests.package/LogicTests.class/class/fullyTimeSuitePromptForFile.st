Examples
fullyTimeSuitePromptForFile
	"for one class: QSOULArithmeticTest fullyTimeSuitePromptForFile"

	"For all: QSOULLogicTests fullyTimeSuitePromptForFile"

	"Prompt for a file name, fully time me, and output the results on a file with the given name."

	
	| fileName |
	fileName := Dialog
		requestFileName: 'Give the name of the file to write the results on:'
		default: 'testTimings.tsf'
		version: #new
		ifFail:
			[^Dialog warn:
					'Not testing anything since there is no file to save the results.'].
	self fullyTimeSuiteOnFileNamed: fileName