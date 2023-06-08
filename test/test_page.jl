@testset "Test formatting a MS page" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:300r")
    label = "Folio 300 recto in the Venetus A"
    rv = "recto"
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA300RN_0470")
    sequence = 599
    samplepage = MSPage(u, label, rv, img, sequence)

    cex = joinpath(pwd(), "data", "hmt-2023a.cex") |> read |> String
    dse = hmt_dse(cex)[1]
    corpus = hmt_normalized(cex)
    commentary = hmt_commentary(cex)[1]


    mdoutput = formatpage(samplepage, 
    dse, corpus,commentary;
    md = true)
    println(mdoutput)

    plaintextoutput =  formatpage(samplepage, 
    dse, corpus,commentary;
    md = false)

    println(plaintextoutput)
end
