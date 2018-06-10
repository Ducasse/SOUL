instance creation
eval: aQueryText in: aRepository withAssociations: aCollection reportingProgressFor: aLabelText
	
	^self eval: aQueryText in: aRepository withAssociations: aCollection
		reportingProgressFor: aLabelText notifying: nil