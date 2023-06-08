

"""Format a line of *Iliad* text."""
function iliadline(psg::CitablePassage; md = true)
    md ? "`$(passagecomponent(psg.urn))` $(psg.text)"  : "$(passagecomponent(psg.urn)) $(psg.text)" 
end


function formatpage(pg::Cite2Urn, dse::DSECollection, corpus::CitableTextCorpus, commentary::CitableCommentary; md = true)
    
    
end


"""Format a plain-text edition of texts in manuscript `ms` using supplied data.  If `md` is true, include markdown formatting."""
function formatms(ms::Cite2Urn, dse::DSECollection, corpus::CitableTextCorpus, commentary::CitableCommentary; md = true)
    pagetext = map(ms.pages) do pg
        format(pg, dse, corpus, commentary; md = md)
    end
    join(pagetext, "\n\n")
end

"""Format a plain-text edition of texts in manuscript `ms` using
the current published release of the HMT archive.  If `md` is true, include markdown formatting."""
function formatms(ms::Cite2Urn; md = true)
    @info("Downloading data from HMT archive...")
    formatms(ms, hmt_dse()[1], hmt_normalized(), hmt_commentary()[1], md = md)
end