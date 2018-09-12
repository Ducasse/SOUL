testing template queries
testScanner
	self
		processQuery:
			' if scan(stMethod,[''?name ?var := 123. ^true''],?tokens)'
		resultsCheck:
			[:results | 
			(results resultsForVariableNamed: 'tokens') first asString ='<xSoulVariable([#''?name'']),xSoulVariable([#''?var'']),colon([#'':'']),binary([#=]),number([123]),period([#''.'']),upArrow([#''^'']),word([#true])>']
		description: 'Does the scanner return the correct tokens?'
		repository:(SoulFactory repository: #parsing)