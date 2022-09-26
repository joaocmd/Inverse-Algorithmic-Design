# module InverseAlgorithmicDesign

using ArgParse

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

# main("/mnt/c/Users/joaodavid/Desktop/practical/Recognition/original.png",
#     maxpointdistance=0.3,
#     scaledetection=:walls,
#     rounddigits=2,
#     generatescalars=false,
#     wallwrappers=true,
#     generatelines=true)

if abspath(PROGRAM_FILE) == @__FILE__
    opts = ArgParseSettings()
    @add_arg_table opts begin
        "path"
            help = "path to the input file"
            required = true
        "--out"
            help = "output file"
            default = joinpath(@__DIR__, "out.jl")
        "--max-point-distance"
            help = "max distance to merge wall junctions"
            default = 0.3
        "--scale-detection"
            help = "method to estimate scale: [:walls, :factor, :width]"
            default = :walls
        "--round-digits"
            help = "number of decimal places (or nothing)"
            default = 2
        "--generate-lines"
            help = "generate line components (x and y)"
            action = :store_true
        # "--generate-scalars"
        #     help = "generate scalar components (widths, offsets, etc.)"
        #     action = :store_true
        # "--no-wall-wrappers"
        #     help = "do not generate wall wrappers"
        #     action = :store_true
    end

    args = parse_args(ARGS, opts)

    main(args["path"],
        maxpointdistance=args["max-point-distance"],
        scaledetection=args["scale-detection"],
        rounddigits=args["round-digits"],
        generatelines=args["generate-lines"],
        out=args["out"],
        generatescalars=false,
        wallwrappers=true)
end

# end
