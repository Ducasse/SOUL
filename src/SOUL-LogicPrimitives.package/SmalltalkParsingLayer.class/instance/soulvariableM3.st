template parsing
soulvariableM3

soulvariable(?var,?tokens1,?tokens2) if 
	equals(?tokens1,<xSoulVariable(?varname)|?tokens2>),[('*List' match: ?varname) not],equals(?var,[(Variable name: (?varname allButFirst: 1)) explicitSoulUp])