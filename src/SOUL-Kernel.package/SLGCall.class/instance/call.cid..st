initialize-release
call: aCallTerm cid: anInteger
	
	callTerm := aCallTerm.
	cid := anInteger.
	answers := OrderedCollection new.
	waitingNodes := OrderedCollection new.
	negativeWaitingNodes := OrderedCollection new.
	nlink := Float infinity.
	comp := false.	"slgQuery := parseBlock value: 'if slg' , (callTerm asString allButLast: 1) , ',' , cid asString , ')'."

	continuationQuery := SLGCall continuationQuery.
	negativeQuery := SLGCall negativeQuery