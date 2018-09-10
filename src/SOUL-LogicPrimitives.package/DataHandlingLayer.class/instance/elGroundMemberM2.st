soul auto saved
elGroundMemberM2

elGroundMember(?El,<?El|?Rest>).
elGroundMember(?El,<?First|?Rest>) if 
	not(equals(?First,?El)),elGroundMember(?El,?Rest)