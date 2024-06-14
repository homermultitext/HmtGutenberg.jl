
"""Format an individual scholion.
$(SIGNATURES)
"""
function formatscholion(scholionparts::Vector{CitablePassage}, commentary::CitableCommentary; md = true, withref = true)
    txt = scholiontext(scholionparts) * "\n"

    referenceurn = collapsePassageBy(scholionparts[1].urn, 1) |> dropexemplar 
    linkurns = filter(pr -> pr[1] == referenceurn, commentary.commentary)
    reply = if isempty(linkurns) 
        withref ? "Unindexed scholion: $(txt)" : txt
    else
        linkref = linkurns[1][2] |> passagecomponent
        if withref
            md ? "On *Iliad* $(linkref): $(txt)\n"  :  "On Iliad $(linkref): $(txt)\n"
        else
            txt
        end
    end
    reply
end

function scholiontext(scholionparts::Vector{CitablePassage})
    content = map(s -> s.text, scholionparts)
    join(content, " ")
end

"""Format a group of scholia for a single page.  If `grouping` is `:byline`, then
cluster scholia by the line they comment on; otherwise, cluster by scholia group 
(relevant for VA and Burney 86).
$(SIGNATURES)
"""
function pagescholiabygroup(msurn::Cite2Urn, psgs::Vector{CtsUrn}, corpus::CitableTextCorpus, commentary::CitableCommentary; md = true)
    scholiapassages = CitablePassage[]
    for scholion in psgs
        @debug("Look for sch $(scholion)")
        matches = filter(psg -> collapsePassageBy(dropexemplar(psg.urn),1) == scholion, corpus.passages)
        if isempty(matches)
            @warn("Error finding $(scholion) in corpus.")
        else
            for s in matches
                push!(scholiapassages, s)
            end
        end
    end
    scholiacontent = filter(psg -> ! isempty(psg.text), scholiapassages)

    content = if msurn == VENETUS_A
        @debug("Format A scholia with md $(md)")
        groupAscholia(scholiacontent, commentary; md = md) 

    elseif msurn == BURNEY86
        groupTscholia(scholiacontent, commentary; md = md, grouping = grouping)
    else
        genericbyline(scholiacontent, commentary; md = md)
    end
    content
end



"""Format one page of Venetus A scholia grouped by document.
$(SIGNATURES)
"""
function groupAscholia(psgs::Vector{CitablePassage}, commentary::CitableCommentary; md = true)
    mainscholia = ["\nMain scholia\n"]
    ail = ["\nInterlinear scholia\n"]
    aim = ["\nIntermarginal scholia\n"]
    aext = ["\nExterior scholia\n"]
    aint = ["\nInterior scholia\n"]

    urnlist = map(psg -> collapsePassageBy(psg.urn, 1),psgs ) |> unique
    for u in urnlist
        tidier = dropexemplar(u)
        workid = parts(workcomponent(u))[2]

        scholiaparts = filter(p -> dropexemplar(collapsePassageBy(p.urn, 1)) == tidier, psgs)
        @debug("Invoking formatscholion with md $(md)")
        if workid == "msA"
            push!(mainscholia, formatscholion(scholiaparts, commentary, md = md))
        elseif workid == "msAext"
            #push!(aext, (scholiaparts, commentary,  md = md))   
            push!(aext, formatscholion(scholiaparts, commentary,  md = md))   
        elseif workid == "msAint"
            push!(aint, formatscholion(scholiaparts, commentary,  md = md))
        elseif workid == "msAim"
            push!(aim, formatscholion(scholiaparts, commentary,  md = md))
        elseif workid == "msAil"
            push!(ail, formatscholion(scholiaparts, commentary,  md = md))
        end
    end
    
    maintext = length(mainscholia) == 1 ? "\n" : join(mainscholia, "\n")
    ailtext =  length(ail) == 1 ? "" : join(ail, "\n")
    aimtext =  length(aim) == 1 ? "" : join(aim, "\n")
    ainttext =  length(aint) == 1 ? "" : join(aint, "\n")
    aexttext = length(aext) == 1 ? "" : join(aext, "\n")
    
    join([maintext, ailtext, aimtext, ainttext, aexttext],"\n")
end

##################################### TBD ##############################################
#
### IMPLEMENT:

function groupTscholia(psgs::Vector{CitablePassage}, commentary::CitableCommentary; md = true, grouping = :byclass)
    "SOME T SCHOLIA"
end
#
########################################################################################



function pagescholiabyline(lines::Vector{CtsUrn}, commentary::CitableCommentary, corpus::CitableTextCorpus; md = true)
    outputlines = String[]
    for ln in lines
        scholiaurns = filter(pr -> pr[2] == ln, commentary.commentary)
        if isempty(scholiaurns)
            #@
        else
            md ? push!(outputlines, "Scholia to *Iliad* $(passagecomponent(ln))\n") : push!(outputlines, "Scholia to Iliad $(passagecomponent(ln))")
            for s in scholiaurns
                @debug("CHECKING $(s[1])")
                scholparts = filter(psg -> urncontains(s[1], psg.urn), corpus.passages)
                scholtext = scholiontext(scholparts) * "\n"
                md ? push!(outputlines, "- $(scholtext)") : push!(outputlines, scholtext)
            end
            push!(outputlines, "\n")
        
        end
    end
    join(outputlines,"\n")
end
