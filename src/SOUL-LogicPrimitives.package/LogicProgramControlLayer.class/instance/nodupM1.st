evals
nodupM1

"tested on 02/04/2002

nodup(?query) computes ?query without duplicate results.
	 Note that this is not a very efficient predicate."

nodup(?query) if 
	findall(?query,?query,?Results),filterDups(?Results,?ResWithoutDuplicates),member(?query,?ResWithoutDuplicates)