module InverseAlgorithmicDesign

include("Recognition.jl")
include("Reconstruction.jl")
include("Write.jl")

function main(file; distancethreshold=0.3, rounddigits=nothing, generatelines=true, out=joinpath(@__DIR__, "out.jl"))
    results = recognize(file)
    elements = reconstruct(results, distancethreshold=distancethreshold)
    write_plan(out, elements.xvalues, elements.yvalues, elements.points, elements.walls, rounddigits=rounddigits, generatelines=generatelines)
end

main("/mnt/c/Users/joaodavid/Desktop/practical/Recognition/original.png",
    distancethreshold=0.3,
    rounddigits=2,
    generatelines=true)
end
