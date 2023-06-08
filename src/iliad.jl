"""Format a line of *Iliad* text.
$(SIGNATURES)
"""
function iliadline(psg::CitablePassage; md = true)
    md ? "`$(passagecomponent(psg.urn))` $(psg.text)"  : "$(passagecomponent(psg.urn)) $(psg.text)" 
end


"""Format a group of *Iliad* lines for a single page.
$(SIGNATURES)
"""
function formatpageiliad(lns::Vector{CtsUrn}, corpus::CitableTextCorpus; md = true)
    iliadlines = String[]
    for ln in lns
        matches = filter(psg -> dropexemplar(psg.urn) == ln, corpus.passages)
        if isempty(matches)
            @warn("Error finding $(ln) in corpus.")
        elseif length(matches) > 1
            @warn("Matched multiple passages in corpus for URN $(ln).")
        else
            push!(iliadlines, iliadline(matches[1], md = md))
        end
    end
    join(iliadlines, "\n")
end