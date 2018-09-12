binary relations
isInstanceVariableInMetaClassXM2

"?InstanceVariable isInstanceVariableInMetaClass: ?Class verifies whether a metaclass ?Class contains
	 a given ?InstanceVariable or returns the appropriate values if one (or more) of the arguments
	 is variable."

?InstanceVariable isInstanceVariableInMetaClass: ?Class if 
	?Class isMetaClass,?InstanceVariable isInstanceVariableInClass: ?Class