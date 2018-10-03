# SOUL
Rescuing the SOUL great logic meta programming language

### Information

* [http://soft.vub.ac.be/SOUL](http://soft.vub.ac.be/SOUL/)

### About SOUL

Program queries can answer important software engineering questions ranging from “is my code bug free?” over “does my code follow the prescribed design?” to “how can my code be refactored?”. SOUL is a Prolog-like language with specialized features for querying programs. SOUL can query the structure (i.e., instructions and their organization) as well as the behavior (i.e., the order in which instructions are executed at run-time and the values instructions operate on) of programs. To this end, several libraries are available for SOUL. As a result, SOUL supports a wide variety of program querying applications. While one SOUL query can enumerate a program's getter methods or Visitor implementations, another can check whether a closed file might be read from at run-time. 

### How to load

Metacello new
  baseline: 'SOUL';
  repository: 'github://Ducasse/SOUL/src';
  load.
