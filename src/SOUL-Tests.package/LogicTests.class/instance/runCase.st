Running
runCase
	"Run the case. Overridden to inform the notifier before and after this happens."

	
	self logicTimer beforeCaseDo: self.
	super runCase.
	self logicTimer afterCaseDo: self