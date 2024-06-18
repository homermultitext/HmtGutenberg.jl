
"""Format a plain-text edition of texts in a manuscript identifed by Cite2Urn, optionally providing a published release of the HMT project.
$(SIGNATURES)
"""
function formatms(msurn::Cite2Urn; cexsrc = hmt_cex(), md = true, grouping = :byclass)
    mschoice = filter(ms -> urn(ms) == msurn, hmt_codices(cexsrc))
    if isempty(mschoice)
        @warn("No manuscripts matched URN $(msurn)")
    else
        ms = mschoice[1]
        dse = hmt_dse(cexsrc)[1]
        corpus = hmt_normalized(cexsrc)
        commentary = hmt_commentary(cexsrc)[1]


        formatms(ms; dse = dse, corpus = corpus, commentary = commentary, md = md, grouping = grouping)
    end
end



"""Format a plain-text edition of texts in manuscript `ms` using supplied data.  If `md` is true, include markdown formatting.
$(SIGNATURES)
"""
function formatms(
    ms::Codex, 
    dse::DSECollection, 
    corpus::CitableTextCorpus, 
    commentary::CitableCommentary; 
    md = true)

    if urn(ms) != VENETUS_A
        @warn("MS $(ms) not implemented.")
        @error("Only VA manuscript currently implemented.")

    end

    pagetext = map(ms.pages) do pg
        @info("Formatting page $(pg)...")
        formatpage(pg, urn(ms), dse, corpus, commentary; md = md)
    end
    join(pagetext, "\n\n")
end



"""Format a plain-text edition of texts in manuscript `ms` using
the current published release of the HMT archive.  If `md` is true, include markdown formatting.
$(SIGNATURES)
"""
function formatms(ms::Codex; 
    dse = hmt_dse()[1],
    corpus = hmt_normalized(),
    commentary = hmt_commentary()[1],
    md = true, grouping = :byclass)
    @info("Assembling data for $(ms)...")
    formatms(ms, dse, corpus, commentary, md = md)
end

