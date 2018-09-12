binary relations
isInstanceVariableInMetaClassChainOfXM2

"?InstanceVariable isInstanceVariableInMetaClassChainOf: ?Class verifies whether a ?Class or
	 one of its (direct or indirect) superclasses declares a given ?InstanceVariable. If ?Class is
	 variable, the class that declares the ?InstanceVariable as well as all of its subclasses are
	 returned. If ?InstanceVariable is variable, all instance variables that are declared in ?Class
	 or one of its superclasses are returned. If both are variable we have the combination of
	 these two situations and we produce all appropriate solutions."

?InstanceVariable isInstanceVariableInMetaClassChainOf: ?Class if 
	?Class isMetaClass,?InstanceVariable isInstanceVariableInClassChainOf: ?Class