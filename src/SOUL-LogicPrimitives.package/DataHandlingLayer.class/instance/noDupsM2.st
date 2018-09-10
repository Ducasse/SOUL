soul auto saved
noDupsM2

"tested on 22/08/2001

noDups(+?ListWithDuplicates,+-?ListWithoutDuplicates) checks whether ?ListWithoutDuplicates
	 is the same (up to a permutation of its elements) as ?ListWithDuplicates after all of its
	 duplicate elements have been removed. The ?ListWithDuplicates is supposed to be instantiated.
	 The ?ListWithoutDuplicates can either be instantiated, or it can be uninstantiated in which
	 case the appropriate value will be generated for it."

noDups(+?listWithDuplicates,?noDupsList) if 
	var(?noDupsList),nonvar(?listWithDuplicates),listAsCollection(?listWithDuplicates,?withDuplicates),listAsCollection(?noDupsList,[?withDuplicates asSet]).
noDups(+?listWithDuplicates,+?noDupsList) if 
	nonvar(?noDupsList),nonvar(?listWithDuplicates),listAsCollection(?listWithDuplicates,?withDuplicates),listAsCollection(?noDupsList,?noDups),[| result withDuplicatesRemoved |
withDuplicatesRemoved := ?withDuplicates asSet.
result := withDuplicatesRemoved size = ?noDups size
	and: [?noDups allSatisfy: [:each | withDuplicatesRemoved includes: each]].
result]