prolog translation
should: soulString translateAs: prologString
	
	| translated parsed |
	parsed := SoulParser parse: soulString.
	translated := parsed terms first asProlog.
	self
		assert: translated = (prologString , '.' , (String with: Character cr))