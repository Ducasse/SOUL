*LiCoR-Core
soulChildren: children
	
	self receiver: (children at: 1).
	self arguments: (children at: 3).	"if the arguments are not set before than the selecter an error will be found"

	self selector: (children at: 2)