template scanning
scanM3

scan(?type,?string,?tokens) if 
	[?type asString matchesPattern: 'st*' ignoreCase: false do: nil],deify(?tokens,[QuotedCodeSmalltalkTokenScanner new breakIntoTokens: ?string])