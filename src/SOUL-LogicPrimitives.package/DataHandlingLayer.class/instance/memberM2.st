soul auto saved
memberM2

"tested on 28/08/2001

member(+-?Element,+-?List) gets or checks a member of a list. If ?Element is instantiated,
	 member/2 will check that it is a member of the list ?List (if ?List is a variable, it will be bound
 	 to a list that contains ?Element). If ?Element is a variable, it will be bound to the first element
	 of ?List. On backtracking, it will be bound to successive elements of ?List.

	 Usage note: As opposed to the implementation of member/2 in Prolog, the predicate will fail 
	 when both ?Element and ?List are variable!"

member(?El,+?Collection) if 
	[?Collection isKindOf: Collection],collectionMember(?El,?Collection).
member(?El,?List) if 
	or(list(?List),var(?List)),listMember(?El,?List)