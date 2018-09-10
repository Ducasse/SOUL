soul auto saved
appendM3

"append/3 join or split lists

tested

append(?First, ?Second, ?Whole) (where ?First, ?Second and ?Whole are either lists or variables) joins or split lists.
If ?First and ?Second are instantiated, the ?Second list is appended to the end of the ?First list to give the ?Whole list.
If ?First, ?Second and ?Whole are instantiated, then test that the ?Whole list begins with the ?First list and that the remainder of the ?Whole list is the ?Second list.
If ?First and ?Whole are instantiated and the ?Whole list starts with the ?First list, then the remainder of the ?Whole list is returned as ?Second.
If ?Second and ?Whole are instantiated and the ?Whole list ends with the ?Second list then the beginning of the ?Whole list is returned as ?First.
If ?Whole is instantiated, the ?Whole list is  split at an arbitrary place to form two new sub-lists ?First and ?Second. Alternative solutions will be provided on backtracking."

append(<>,?List,?List).
append(<?ElFirst|?RestFirst>,?Second,<?ElFirst|?Rest>) if 
	append(?RestFirst,?Second,?Rest)