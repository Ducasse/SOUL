SLG resolution
slgcallM5

slgcall(?id,?vars,?call,?delay,?cont) if 
	[SoulFactory slgcall: ?call forCID: ?id variables: ?vars delay: ?delay
	continuation: ?cont.
false]