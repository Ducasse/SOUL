evals
countM2

"count(+?Query,?NumberOfResults) counts how many results there are for ?Query. Note that
the query is supposed to be instantiated upon calling this predicate."

count(+?Query,?NumberOfResults) if 
	findall(dummy,?Query,?list),length(?list,?NumberOfResults)