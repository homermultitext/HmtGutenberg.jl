using Pkg
Pkg.activate("..")


using Test
using TestSetExtensions

using HmtGutenberg
using HmtArchive.Analysis
using CitableText, CitableCorpus
using CitableObject
using CitablePhysicalText


@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end

