private
fixClean: fixVisitor
	
	conclusion accept: fixVisitor.
	condition do: [:each | each accept: fixVisitor]