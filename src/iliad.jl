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
    []
end