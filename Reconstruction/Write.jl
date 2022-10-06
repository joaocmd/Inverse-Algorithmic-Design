# export write_plan

import JuliaFormatter

include("ReconstructionTypes.jl")

"Defines values' symbols, such as `x1 = 1.5`."
function define_values(prefix, indextovalue, rounddigits)
    get_value(idx) = rounddigits === nothing ? indextovalue[idx] : round(indextovalue[idx], digits=rounddigits)

    return [:($(Symbol(prefix, idx)) = $(get_value(idx))) for idx in sort(collect(keys(indextovalue)))]
end

"Generates the points' symbols using the values' indices."
function define_points(indextovalue)
    function define_point(idx)
        x, y = indextovalue[idx]
        return :($(Symbol(:p, idx)) = xy($(Symbol(:x, x)), $(Symbol(:y, y))))
    end
    return [define_point(idx) for idx in sort(collect(keys(indextovalue)))]
end

"Generates the points' symbols using the values directly."
function define_points(indextovalue, xvalues, yvalues, rounddigits)
    get_value(val) = rounddigits === nothing ? val : round(val, digits=rounddigits)

    function define_point(idx)
        x, y = indextovalue[idx]
        x, y = get_value(xvalues[x]), get_value(yvalues[y])
        return :($(Symbol(:p, idx)) = xy($x, $y))
    end
    return [define_point(idx) for idx in sort(collect(keys(indextovalue)))]
end

"Generates the points' symbols."
function define_points(indextovalue, xvalues, yvalues, rounddigits, generatelines)
    return generatelines ? define_points(indextovalue) : define_points(indextovalue, xvalues, yvalues, rounddigits)
end

"Defines walls' symbols, such as `wall1 = wall([p1, p2])`."
function define_walls(walls, tvalues, dvalues, wvalues, rounddigits, generatescalars, wallwrappers)
    get_value(val) = rounddigits === nothing ? val : round(val, digits=rounddigits)
    get_value(idx, values) = generatescalars ? idx : get_value(values[idx])

    function define_element(door::IndexedDoor)
        if !occursin("single", door.type)
            return :(door($(get_value(door.p)), $(get_value(door.width, dvalues))))
        else
            type = Symbol(last(door.type, 2))
            return :(door($(get_value(door.p)), $(get_value(door.width, dvalues)), $type))
        end
    end

    define_element(window::IndexedWindow) = :(window($(get_value(window.p)), $(get_value(window.width, wvalues))))

    function define_wall(idx, wall)
        p = Symbol(:p, wall.p)
        q = Symbol(:p, wall.q)

        if wallwrappers
            fname = wall.thickness == 1 ? :thinwall : :thickwall
            if isempty(wall.elements)
                return :($fname([$p, $q]))
            else
                return :($fname([$p, $q]; parts=[$(map(define_element, wall.elements)...)]))
            end
        else
            if isempty(wall.elements)
                return :(wall([$p, $q], $(get_value(wall.thickness, tvalues))))
            else
                return :(wall([$p, $q], $(get_value(wall.thickness, tvalues)); parts=[$(map(define_element, wall.elements)...)]))
            end
        end
    end
    return [define_wall(idx, wall) for (idx, wall) in enumerate(sort(walls))]
end

"Defines railings' symbols, such as `railing([p1, p2])`."
function define_railings(railings, thickness, rounddigits)
    get_value(val) = rounddigits === nothing ? val : round(val, digits=rounddigits)

    function define_railing(railing)
        p = Symbol(:p, railing.p)
        q = Symbol(:p, railing.q)

        return :(railing([$p, $q], $(get_value(thickness))))
    end
    return [define_railing(railing) for railing in sort(railings)]
end

"Defines wrappers for thin and thick walls, only used when there are only two wall clusters."
function define_wall_wrappers(thicknesses, rounddigits)
    get_value(val) = rounddigits === nothing ? val : round(val, digits=rounddigits)

    function define_wrapper(thickness, name)
        return "$(name)wall(wallpath; parts=[]) = wall(wallpath, $(get_value(thickness)); parts=parts)"
    end
    return map(t -> define_wrapper(t...), zip(thicknesses, ["thin", "thick"]))
end

"Defines symbols. Symbols that are not yet implemented are returned as nothing"
function define_symbols(elements, rounddigits)
    get_value(val) = rounddigits === nothing ? val : round(val, digits=rounddigits)

    define_element(sink::Sink) = :(sink(xy($(get_value(sink.c.x)), $(get_value(sink.c.y))), $(sink.angle)))
    define_element(toilet::Toilet) = :(toilet(xy($(get_value(toilet.c.x)), $(get_value(toilet.c.y))), $(toilet.angle)))
    define_element(closet::Closet) = :(closet(xy($(get_value(closet.p.x)), $(get_value(closet.p.y))), xy($(get_value(closet.q.x)), $(get_value(closet.q.y)))))
    define_element(_) = nothing

    return map(define_element, elements)
end

function write_plan(file, xvalues, yvalues, points, walls, thicknesses, dwidths, wwidths, railings, railingthickness, symbols;
    rounddigits=nothing, generatelines=true, generatescalars=false, wallwrappers=true)
    # TODO: generatescalars not currently supported
    createwallwrappers = wallwrappers && length(thicknesses) == 2

    open(file, "w") do io
        println(io, :(import Pkg))
        println(io, :(Pkg.add(Pkg.PackageSpec(name="KhepriBase", url="https://github.com/aptmcl/KhepriBase.jl"))))
        println(io, :(Pkg.add(Pkg.PackageSpec(name="KhepriAutoCAD", url="https://github.com/aptmcl/KhepriAutoCAD.jl"))))
        println(io, "##\n")

        println(io, :(using KhepriAutoCAD: xy, delete_all_shapes))
        println(io, :(include("OutAux.jl")))
        println(io)

        if createwallwrappers
            for wrapper in define_wall_wrappers(sort([values(thicknesses)...]), rounddigits)
                println(io, wrapper)
            end
            println(io)
        end

        if generatelines
            xx = define_values("x", xvalues, rounddigits)
            foreach(x -> println(io, x), xx)
            println(io)

            yy = define_values("y", yvalues, rounddigits)
            foreach(y -> println(io, y), yy)
            println(io)
        end

        pp = define_points(points, xvalues, yvalues, rounddigits, generatelines)
        foreach(p -> println(io, p), pp)
        println(io, "\n##\n")

        println(io, :(delete_all_shapes()))
        println(io)

        walls = define_walls(walls, thicknesses, dwidths, wwidths, rounddigits, generatescalars, createwallwrappers)
        foreach(wall -> println(io, wall), walls)
        println(io)

        railings = define_railings(railings, railingthickness, rounddigits)
        foreach(railing -> println(io, railing), railings)

        println(io, "\n##\n")
        symbols = filter(!isnothing, define_symbols(symbols, rounddigits))
        foreach(symbol -> println(io, symbol), symbols)

        println(io, "\n##\n")

        if generatelines
            println(io, :(xnames = [n for n in names(Main) if occursin(r"^x\d+$", string(n))]))
            println(io, :(ynames = [n for n in names(Main) if occursin(r"^y\d+$", string(n))]))
            println(io)

            println(io, :(show_x_lines(xnames, ynames; labels_only=false)))
            println(io, :(show_y_lines(ynames, xnames; labels_only=false)))
        end
        println(io, :(show_points([n for n in names(Main) if occursin(r"^p\d+$", string(n))])))
    end

    JuliaFormatter.format(file, JuliaFormatter.MinimalStyle())
end
