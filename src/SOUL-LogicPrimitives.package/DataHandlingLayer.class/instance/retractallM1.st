soul auto saved
retractallM1

"not tested

retractall(+?Term) retracts all occurences of a clause with a given head ?Term from the default logic repository"

retractall(&term) if 
	nonvar(?term),getRepository(?repository),getEnv(?env,?),[?repository
	retractAll: (&term predicateInEnv: ?env startAt: nil)
	multiplicity: &term multiplicity]