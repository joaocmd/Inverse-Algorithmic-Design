module InverseAlgorithmicDesign

include("Recognition.jl")
include("Reconstruction.jl")
include("Write.jl")

function main(file; maxpointdistance=0.3, rounddigits=nothing, generatelines=true, generatescalars=false, out=joinpath(@__DIR__, "out.jl"))
    results = recognize(file)
    elements = reconstruct(results, maxpointdistance=maxpointdistance)

    write_plan(out,
        elements.xvalues, elements.yvalues, elements.points,
        elements.walls, elements.tvalues, elements.dvalues, elements.wvalues,
        rounddigits=rounddigits,
        generatelines=generatelines,
        generatescalars=generatescalars
    )
end

main("/mnt/c/Users/joaodavid/Desktop/practical/Recognition/original.png",
    maxpointdistance=0.3,
    rounddigits=2,
    generatelines=true,
    generatescalars=false)
end
