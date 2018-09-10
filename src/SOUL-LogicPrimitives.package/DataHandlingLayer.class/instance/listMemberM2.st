soul auto saved
listMemberM2

listMember(?El,?List) if 
	ground(?El),elGroundMember(?El,?List).
listMember(?El,?List) if 
	nonground(?El),list(?List),elNotGroundMember(?El,?List)