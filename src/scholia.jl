

"""Format a group of scholia for a single page.  If `grouping` is `:byline`, then
cluster scholia by the line they comment on; otherwise, cluster by scholia group 
(relevant for VA and Burney 86).
$(SIGNATURES)
"""
function formatpagescholia(lns::Vector{CtsUrn}, corpus::CitableTextCorpus, commentary::CitableCommentary; md = true, grouping = :byclass)
    []
end