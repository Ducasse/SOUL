I hold the table that the Scanner or similar application uses to look up characters by character value.  If the character value is out of range, I answer one of several default values, depending on how the character classifies itself.

Instance Variables:
	value0	<Object>  "an explicit entry for index=0"
	defaultValue	<Object>  "the value for undefined characters"
	letterValue	<Object>  "the default value for letters"
	digitValue	<Object>  "the default value for digits"
	separatorValue	<Object>  "the default value for separators (whitespace)"

Note that we have to override at:put: to make the defaulting mechanism work properly, because at: and at:put: both send subscriptBoundsError:, which loses both the information as to which message was sent and (in the case of at:put:) what value was being stored.  This is a design bug in the implementation of at: and at:put:.