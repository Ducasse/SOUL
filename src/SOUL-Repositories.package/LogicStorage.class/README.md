The main purpose of LogicStorage and its subclasses is to serve as storage for the source of SOUL programs in a format that can be easily written to disk and especially stored on a Store facility. A Store database can only be used to hold classes and methods and can not be easily extended to allow for other kinds of data, hence we map SOUL programs onto a representation that Store understands: classes and methods. LogicStorage classes are not directly used by the evaluation to lookup rules and facts, see LogicRepository for that.

SOUL programs are organized into 'layers', each LogicStorage subclass represents one such layer.

The instance methods of a LogicStorage subclass are simply used to hold the source of the program, the class methods of LogicStorage provide a clean way of accessing and modifying the parsed representation of these programs. The parsed representation is contained in the clausesStore class instance variable.

Each instance method holds the source for all the rules and facts in the layer that implement the same predicate. The name of this method is derived from the name of the predicate. The methods are kept in two-way sync with the parsed representation, when one changes the other is updated as well.

The methods in the following protocols provide the clean interface for accessing and editing the parsed representation:

- 'accessing' provides methods to retrieve the clauses in the layer
- 'editing' provides ways for adding, removing, replacing and changing the order of the clauses in the program
- 'protocol support' provides ways of organizing the predicates contained in the layer into protocols

[ TODO: 'editing' relies on identity of clauses, err what else? ]


