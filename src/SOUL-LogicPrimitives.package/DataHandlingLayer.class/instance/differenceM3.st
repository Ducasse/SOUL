soul auto saved
differenceM3

"converted on 2001-11-30 by Tom Mens

tested

calculates the set difference"

difference(?Set1,?Set2,?Diff) if 
	findall(?El,and(includes(?El,?Set1),not(includes(?El,?Set2))),?Diff)