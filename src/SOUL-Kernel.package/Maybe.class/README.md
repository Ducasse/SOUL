Instances represent unification degrees and behave as booleans.

Although regular Soul only uses crisp degrees, putting its definition here instead of in the fuzzy Soul package saves us from having to specialize MLI's and domain-specific unifications for both variants. 

For instance, domain-specific unifications defined by Cava on the org.eclipse.jdt.dom hierarchy use this class rather than booleans such that one definition suffices for crisp Soul and fuzzy Soul. 