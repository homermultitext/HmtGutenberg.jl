# Build docs from root directory of repository:
#
#     julia --project=docs/ docs/make.jl
#
# Serve docs from repository root:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, HmtGutenberg

makedocs(
    sitename = "HmtGutenberg.jl",
    pages = [
        "Overview" => "index.md",
        "Generating editions for a page" => "puretextpage.md",
        "Generating editions for multiple pages" => "puretextpages.md",
        "API Documentation" => "apis.md",
        ]
    )


deploydocs(
    repo = "github.com/homermultitext/HmtGutenberg.jl.git",
) 