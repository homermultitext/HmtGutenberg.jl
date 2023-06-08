using Pkg
Pkg.activate("..")


using Test
using TestSetExtensions

using HmtGutenberg
using CitableText, CitableCorpus

@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end

