@testset "Test processing a manuscript" begin
    cex = joinpath(pwd(), "data", "hmt-2024a.cex") |> read |> String
    mslist = hmt_codices(cex)
    samplems = Codex("2-page sample codex", mslist[6].pages[602:603])
    
end
