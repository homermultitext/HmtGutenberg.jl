using HmtGutenberg
using CitableBase
using HmtArchive.Analysis
src  = hmt_cex()
hmt_releaseinfo(src)
implemented = [
    HmtGutenberg.VENETUS_A
]
mss = hmt_codices(src)


for ms in mss
    if urn(ms) in implemented
        outfile = "$(collectionid).md"
        ms_md = formatms(ms)
        open(outfile,"w") do io
            write(io, ms_md)
        end
    end
end
#ms_md = formatms(HmtGutenberg.VENETUS_A)