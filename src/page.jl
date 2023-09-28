"""Format a plain-text edition of manuscript page `pg` using the supplied data for text corpus, commentary relations, and DSE indexing.  If `md` is true, include markdown formatting.
$(SIGNATURES)
"""
function formatpage(pg::MSPage, 
    msurn::Cite2Urn,
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
        @info("Found $(length(reff)) Iliad lines")
        if md 
            push!(outputlines, "*Iliad* $(reff[1])-$(reff[end])\n")
        else
            push!(outputlines, "Iliad $(reff[1])-$(reff[end])\n")
        end
    end
    push!(outputlines, formatpageiliad(iliadlines, corpus; md = md))
    
    scholia = filter(u -> startswith(workcomponent(u), "tlg5026"), alltexts)
    if isempty(scholia)
    else
        @info("Found $(length(scholia)) scholia on $(length(reff)) Iliad lines")
        if md 
            push!(outputlines, "\nScholia to *Iliad* $(reff[1])-$(reff[end])\n")
        else
            push!(outputlines, "\nScholia to Iliad $(reff[1])-$(reff[end])\n")
        end

        if grouping == :byclass && (msurn == VENETUS_A || msurn == BURNEY86)
            push!(outputlines, pagescholiabygroup(msurn, scholia, corpus, commentary; md = md))

        else
            push!(outputlines, pagescholiabyline(iliadlines, commentary, corpus; md = md))
        end
    end

    join(outputlines, "\n")
    
end

"""Parse a given release of the HMT archive or download the current published release of the archive, and format a plain-text edition of the manuscript page identified by URN `pgurn`.  If `md` is true, include markdown formatting.
$(SIGNATURES)
"""
function formatpage(pgurn::Cite2Urn;
    cex = nothing,  md = true, grouping = :byclass)
    pagecollection = pgurn |> dropobject
    if isnothing(cex)
        @info("Downloading latest HMT release...")
        cex = hmt_cex()
    end
    @info("Parsing HMT publication...")
    codices = hmt_codices(cex)
    pagecodex = filter(thecodex -> urn(thecodex) == pagecollection,  codices)
    if length(pagecodex) != 1
        @warn("Could not find a unique codex for a page $(pgurn)")
        nothing
    else

        mspage = filter(pg -> urn(pg) == pgurn, pagecodex[1].pages)
        if isempty(mspage)
            @warn("Could not find unique page in MS $(pagecodex[1]) for $(pgurn)")
        end
        dse =  hmt_dse(cex)
        if isempty(dse)
            @warn("No DSE records found.")
        else
            dse = dse[1]
        end
        commentary = hmt_commentary(cex)
        if isempty(commentary)
            @warn("No commentary found.")
        else
            commentary = commentary[1]
        end 
        corp = hmt_normalized(cex)
        if isempty(mspage)
            @warn("Could find `mspage`")
        else
            mspage = mspage[1]
        end
        codexurn = nothing
        if isempty(pagecodex)
            @warn("No codex found for $(pgurn)")
        else
            codexurn = urn(pagecodex[1])
        end
        @info("Finished checking params")

        formatpage(mspage, 
            codexurn, 
            dse, 
            corp,
            commentary;
            md = md)
            
    end
end


"""Format a list of pages identified by Cite2Urn.
$(SIGNATURES)
"""
function formatpages(pglist::Vector{Cite2Urn};
    cex = nothing,  md = true, grouping = :byclass
    )
    stringlist = map(pg -> formatpage(pg, cex = cex, md = md, grouping = grouping), pglist)
    join(stringlist, "\n\n")
end