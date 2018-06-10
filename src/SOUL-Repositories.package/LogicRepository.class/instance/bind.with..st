repository composition
bind: aVariable with: aRepository
	
	| varName |
	"Bind a repository variable to a repository"

	varName := aVariable name.
	self bindName: varName with: aRepository