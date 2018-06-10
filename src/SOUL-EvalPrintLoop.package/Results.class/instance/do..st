public-enumerating
do: aBlock
	"Enumerate over the results. aBlock is a smalltalkblock that must have 1  
	parameter, which will be bound to a Collection of Binding, for  
	each subsequent result"

	
	1
		to: self size
		do:
			[:index | 
			| collect |
			collect := OrderedCollection new.
			results
				keysAndValuesDo:
					[:key :value | 
					collect
						add:
							(Binding
								var: key
								value: (value at: index))].
			aBlock value: collect]