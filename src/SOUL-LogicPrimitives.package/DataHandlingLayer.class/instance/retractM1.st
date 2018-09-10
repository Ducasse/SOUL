soul auto saved
retractM1

"not tested

retract(+?Term)  retracts the first occurence of a clause with a given head ?Term from the default logic repository"

retract(&term) if 
	nonvar(&term),getRepository(?repository),getEnv(?env,?),[?repository
	retract: (&term predicateInEnv: ?env startAt: nil)
	multiplicity: &term multiplicity]