instance creation
eval: aQueryText in: aRepository
	
	^self eval: aQueryText in: aRepository withAssociations: #() notifying:
			nil