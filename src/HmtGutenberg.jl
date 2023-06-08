module HmtGutenberg

using HmtArchive.Analysis
using CitableBase, CitableText, CitableCorpus
using CitableObject
using CitablePhysicalText
using CitableAnnotations

using Documenter, DocStringExtensions


include("constants.jl")
include("iliad.jl")
include("scholia.jl")
include("page.jl")
include("manuscript.jl")

export formatpage, formatms

end # module HmtGutenberg
