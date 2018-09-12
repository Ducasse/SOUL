The Reification layer reifies the basic Smalltalk entities.

It is split up in PackagingReification and SmalltalkReification.
The reason for doing so is that packaging is essentially an environment issue
(there are no real language primitives that deal with packaging), whereas the
Smalltalk reification reifies the Smalltalk primitive language constructs.