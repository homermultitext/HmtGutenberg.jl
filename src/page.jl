



"""Format a plain-text edition of manuscript page `pg` using supplied data.  If `md` is true, include markdown formatting.
$(SIGNATURES)
"""
function formatpage(pg::MSPage, 
    dse::DSECollection, 
    corpus::CitableTextCorpus, 
    commentary::CitableCommentary; 
    md = true, grouping = :byclass)

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
    push!(outputlines, formatpageiliad(iliadlines, corpus; md = md))
    

    if grouping == :byline
        # Group by Iliad line

    else
        
    end

    join(outputlines, "\n")
    
end

