DerelictFmod [![Build Status](https://travis-ci.org/Extrawurst/DerelictFmod.svg)](https://travis-ci.org/Extrawurst/DerelictFmod)
============

Note:
Supports fmod version 1.09.08

A dynamic binding to [Fmod](http://www.fmod.org/) low level api and fmodstudio api (c-api) for the D Programming Language.

For information on how to build DerelictFmod and link it with your programs, please see the post [Using Derelict](https://derelictorg.github.io/using.html) at the The One With D.

See more detailed example app [here](source/app.d).

Just initializing of the bindings:

```D
import derelict.fmod.fmod;

void main() {
    // Load the Fmod library.
    DerelictFmod.load();
    // Load the Fmod studio library.
    DerelictFmodStudio.load();

    // Now Fmod functions can be called.
    ...
}
```

Note: Do not forget to download the official fmod binaries (shared libraries).
