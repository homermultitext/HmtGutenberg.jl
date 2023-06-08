@testset "Test formatting a MS page" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:300r")
    pglabel = "Folio 300 recto in the Venetus A"
    rv = "recto"
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA300RN_0470")
    sequence = 599
    samplepage = MSPage(u, pglabel, rv, img, sequence)

    cexdata = joinpath(pwd(), "data", "hmt-2023a.cex") |> read |> String
    dse = hmt_dse(cexdata)[1]
    corpus = hmt_normalized(cexdata)
    commentary = hmt_commentary(cexdata)[1]
    ms = hmt_codices(cexdata)[6]


    mdoutput = formatpage(samplepage, 
    urn(ms), dse, corpus,commentary;
    md = true)
    println(mdoutput)

    plaintextoutput =  formatpage(samplepage, 
    urn(ms), dse, corpus,commentary;
    md = false)

    println(plaintextoutput)
end
