DerelictFmod
============

Note:
Supports fmod version 1.06.07

A dynamic binding to [Fmod](http://www.fmod.org/) low level api (c-api) for the D Programming Language.

For information on how to build DerelictFmod and link it with your programs, please see the post [Using Derelict](http://dblog.aldacron.net/derelict-help/using-derelict/) at the The One With D.

Initialization example:

```D
import derelict.fmod.fmod;

void main() {
    // Load the Fmod library.
    DerelictFmod.load();

    // Now Fmod functions can be called.
    ...
}
```

Note: Do not forget to download the official fmod binaries (shared libraries).
