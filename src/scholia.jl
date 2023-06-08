

"""Format a group of scholia for a single page.  If `grouping` is `:byline`, then
cluster scholia by the line they comment on; otherwise, cluster by scholia group 
(relevant for VA and Burney 86).
$(SIGNATURES)
"""
function formatpagescholia(msurn::Cite2Urn, psgs::Vector{CtsUrn}, corpus::CitableTextCorpus, commentary::CitableCommentary; md = true, grouping = :byclass)
    scholiapassages = CitablePassage[]
    for scholion in psgs
        @info("Look for sch $(scholion)")
        matches = filter(psg -> collapsePassageBy(dropexemplar(psg.urn),1) == scholion, corpus.passages)
        if isempty(matches)
            @warn("Error finding $(scholion) in corpus.")
        else
            for s in matches
                push!(scholiapassages, s)
            end
        end
    end
    
    content = if msurn == VENETUS_A
        formatAscholia(scholiapassages, commentary; md = md, grouping = grouping)

    elseif msurn == BURNEY86
        formatTscholia(scholiapassages, commentary; md = md, grouping = grouping)
    else
        formatgenericscholia(scholiapassages, commentary; md = md)
    end

    content
end

"""Format an individual scholion.
$(SIGNATURES)
"""
function formatscholion(scholion::CitablePassage, commentary::CitableCommentary; md = true)
end

function groupAscholia(psgs::Vector{CitablePassage}, commentary::CitableCommentary; md = true)
    "A scholia grouped by class"
end

function bylineAscholia(psgs::Vector{CitablePassage}, commentary::CitableCommentary; md = true)
    "A scholia grouped by line of Iliad"
end

"""Format one page of Venetus A scholia.
$(SIGNATURES)
"""
function formatAscholia(psgs::Vector{CitablePassage}, commentary::CitableCommentary; md = true, grouping = :byclass)
    if grouping == :byclass
        groupAscholia(psgs, commentary; md = md)
    else
        bylineAscholia(psgs, commentary; md = md)
    end
end





### IMPLEMENT THESE:

function formatTscholia(psgs::Vector{CitablePassage}, commentary::CitableCommentary; md = true, grouping = :byclass)
    "SOME T SCHOLIA"
end

function formatgenericscholia(psgs::Vector{CitablePassage}, commentary::CitableCommentary; md = true)
    "SOME GENERIC SCHOLIA"
end