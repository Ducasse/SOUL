classes
classCallsMethodXM2

"Find all methods ?Method that potentially get called from within ?Class"

?Class classCallsMethod: ?Method if 
	?Caller isMethodInClass: ?Class,?Caller methodCallsMethod: ?Method