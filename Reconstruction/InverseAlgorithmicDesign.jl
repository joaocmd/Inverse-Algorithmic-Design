module InverseAlgorithmicDesign

include("Recognition.jl")
include("Reconstruction.jl")
include("Write.jl")

function main(file;
    saverecognition=nothing,
    scaledetection=:walls,
    maxpointdistance=0.3,
    rounddigits=nothing,
    generatescalars=false,
    wallwrappers=true,
    generatelines=true,
    out=joinpath(@__DIR__, "out.jl")
)

    results = recognize(file, scaledetection)
    elements = reconstruct(results, maxpointdistance=maxpointdistance)

    write_plan(out,
        elements.xvalues, elements.yvalues, elements.points,
        elements.walls, elements.tvalues, elements.dvalues, elements.wvalues,
        elements.symbols;
        rounddigits=rounddigits,
        generatescalars=generatescalars,
        wallwrappers=wallwrappers,
        generatelines=generatelines
    )
end

main("/mnt/c/Users/joaodavid/Desktop/practical/Recognition/original.png",
    maxpointdistance=0.3,
    scaledetection=:walls,
    rounddigits=2,
    generatescalars=false,
    wallwrappers=true,
    generatelines=true)
end
