list handling
testlist
	"list/1"

	
	self processQuery: ' if tail(?l,<[1]>),list(?l)' description:
			'Is the empty tail of a list a list ?'.
	self processQuery: ' if tail(?l,<[1],[2],[3]>),list(?l)' description:
			'Is the non-empty tail of a list a list ?'.
	self processQuery: ' if not(list(foo([2])))' description:
			'Is a compound term not a list ?'.
	self processQuery: ' if not(list(?v))' description:
			'Is an unbound variable not a list ?'