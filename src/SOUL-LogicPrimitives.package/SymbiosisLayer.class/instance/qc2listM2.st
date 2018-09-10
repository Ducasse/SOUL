soul auto saved
qc2listM2

"Convert a quotedcode to its list representation. The reverse remains to be done"

qc2list(+?qc,?list) if 
	envLookup(?qc,?qcPointer),envLookup(?list,?listPointer),getEnv(?env,?idx),[| theList startIndex |
theList := ?qc asList.
startIndex := ?env startUnify: 0.
?listPointer term
	unifyWith: theList
	inEnv: ?env
	myIndex: ?listPointer envIndex
	hisIndex: ?qcPointer envIndex
	inSource: true]