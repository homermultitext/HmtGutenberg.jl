

"""Format a line of *Iliad* text."""
function iliadline(psg::CitablePassage; md = true)
    md ? "`$(passagecomponent(psg.urn))` $(psg.text)"  : "$(passagecomponent(psg.urn)) $(psg.text)" 
end