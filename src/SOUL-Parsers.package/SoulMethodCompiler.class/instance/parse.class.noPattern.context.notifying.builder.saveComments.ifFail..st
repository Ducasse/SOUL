compilation
parse: aStream class: class noPattern: noPattern context: context notifying: handler builder: builder saveComments: saveComments ifFail: failblock
	"this is invoked during the compilation of pieces of QSoul code, after the QSoul code was converted to a Smalltalk representation. Hence the regular Smalltalk parser should be used to handle this."

	
	^Parser new parse: aStream class: class noPattern: noPattern context:
			context notifying: handler builder: builder saveComments: saveComments
		ifFail: failblock