# Pure-text editions

Pure-text editions are organized by physical page of a manuscript. You can create pure-text editions for a single page with the `formatpage` functoin, or for an entire manuscript with the `formatms` function.  Both functions work with structures from the `HmtArchive` pacakge's `Analysis` module, so you'll want to use it when creating parameters to these functions.

```@example puretext
using HmtGutenberg
using HmtArchive.Analysis
```