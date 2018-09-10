soul auto saved
tailM2

"tested on 22/08/2001

tail(+-?RestList, +?List) unifies ?RestList with ?List without its first element.
	 ?RestList can either be instantiated or not. ?List must be instantiated, although
	 it may be only partially instantiated."

tail(?Rest,<?First|?Rest>)