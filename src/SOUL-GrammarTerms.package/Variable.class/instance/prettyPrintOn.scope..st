printing
prettyPrintOn: aStream scope: id
	"see comment in AbstractTerm"
	
	aStream withAttribute: (TextColor color:(Color r:0 g:0 b:256)) do: [
	aStream write: '?' , name].
	