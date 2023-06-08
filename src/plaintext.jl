

"""Format a line of *Iliad* text."""
function iliadline(psg::CitablePassage; md = true)
    md ? "`$(passagecomponent(psg.urn))` $(psg.text)"  : "$(passagecomponent(psg.urn)) $(psg.text)" 
end


"""Format a plain-text edition of manuscript page `pg` using supplied data.  If `md` is true, include markdown formatting."""
function formatpage(pg::MSPage, 
    dse::DSECollection, 
    corpus::CitableTextCorpus, 
    commentary::CitableCommentary; 
    md = true)

    outputlines = String[]
    md ? push!(outputlines, "### $(label(pg))\n") : push!(outputlines, label(pg) * "\n")




    alltexts = textsforsurface(pg.urn, dse)
    iliadlines = filter(u -> startswith(workcomponent(u), "tlg0012.tlg001"), alltexts)
    reff = map(u -> passagecomponent(u), iliadlines)
    @info("Formatting page $(pg)")
    if isempty(iliadlines) 
    else
        if md 
            push!(outputlines, "*Iliad* $(reff[1])-$(reff[end])")
        else
            push!(outputlines, "Iliad $(reff[1])-$(reff[end])")
        end
    end

    join(outputlines, "\n")
    
end


"""Format a plain-text edition of texts in manuscript `ms` using supplied data.  If `md` is true, include markdown formatting."""
function formatms(
    ms::Codex, 
    dse::DSECollection, 
    corpus::CitableTextCorpus, 
    commentary::CitableCommentary; 
    md = true)

    pagetext = map(ms.pages) do pg
        formatpage(pg, dse, corpus, commentary; md = md)
    end
    join(pagetext, "\n\n")
end

"""Format a plain-text edition of texts in manuscript `ms` using
the current published release of the HMT archive.  If `md` is true, include markdown formatting."""
function formatms(ms::Codex; md = true)
    @info("Downloading data from HMT archive...")
    formatms(ms, hmt_dse()[1], hmt_normalized(), hmt_commentary()[1], md = md)
end