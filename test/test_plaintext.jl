@testset "Test formatting Iliad line" begin
    u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msA.normalized:1.1")
    txt =  "Μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος"
    psg = CitablePassage(u, txt)

    expectedmd = "`1.1` Μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος"
    @test HmtGutenberg.iliadline(psg) == expectedmd

    expectedtext = "1.1 Μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος"
    @test HmtGutenberg.iliadline(psg; md = false) == expectedtext

end