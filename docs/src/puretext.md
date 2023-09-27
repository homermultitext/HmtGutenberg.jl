# Pure-text editions

Pure-text editions are organized by physical page of a manuscript. You can create pure-text editions for texts on a single page with the `formatpage` function, for a list of pages with the `formatpages` function, or for an entire manuscript with the `formatms` function. 

All three functions share some optional parameters:

- `cex` (default value: `nothing`) You can provide the full text in CEX format of a published release of the Homer Multitext project. If no value is provided, the current published release is downloaded over the internet and used.
- `md` (default value: `true`) Include markdown formatting.  If false, plain text without markdown is created.
- `grouping` (default value: `:byclass`) For the Venetus A or Burney 86 manuscripts, *scholia* are grouped together by the zone on the manuscript page they belong to (such as interior, interlinear, intermarginal). If any other value is provided, *scholia* are grouped by the line they comment on.

```@example puretext
using HmtGutenberg
using CitableObject
pwd()
```