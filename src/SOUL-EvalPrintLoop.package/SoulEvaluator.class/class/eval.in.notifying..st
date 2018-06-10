instance creation
eval: aQueryText in: aRepository notifying: aTextController
	
	^self eval: aQueryText in: aRepository withAssociations: #() notifying:
			aTextController