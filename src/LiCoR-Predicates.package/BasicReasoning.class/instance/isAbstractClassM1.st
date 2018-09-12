classes
isAbstractClassM1

"A class ?Class is an abstract class if it has an abstract method in its class chain that is not overridden"

?Class isAbstractClass if 
	?Method isMethodInClassChainOfClass: ?Class,?Method isAbstractMethod,not(and(?M2 isMethodInClassChainOfClass: ?Class,?M2 methodOverridesMethod: ?Method))