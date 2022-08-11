# export write_plan

include("ReconstructionTypes.jl")

"Defines values' symbols, such as `x1 = 1.5`."
function define_values(prefix, indextovalue, rounddigits)
    get_value(idx) = rounddigits === nothing ? indextovalue[idx] : round(indextovalue[idx], digits = rounddigits)

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
    get_value(val) = rounddigits === nothing ? val : round(val, digits = rounddigits)

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

# TODO: Usar um Dict como nos outros lados
"Defines walls' symbols, such as `wall1 = MyWall([p1, p2])`."
function define_walls(walls, rounddigits)
    get_value(val) = rounddigits === nothing ? val : round(val, digits = rounddigits)

    define_element(element::EmbeddedDoor) = :(mydoor($(get_value(element.p)), $(get_value(element.width))))
    define_element(element::EmbeddedWindow) = :(mywindow($(get_value(element.p)), $(get_value(element.width))))

    function define_wall(idx, wall)
        p = Symbol(:p, wall.p)
        q = Symbol(:p, wall.q)

        if isempty(wall.elements)
            return :($(Symbol(:wall, idx)) = mywall([$p, $q]))
        else
            # door_locs = [define_door(door) for door in wall.elements]
            return :($(Symbol(:wall, idx)) = mywall([$p, $q], parts = [$(map(define_element, wall.elements)...)]))
        end
    end
    return [define_wall(idx, wall) for (idx, wall) in enumerate(sort(walls))]
end

function write_plan(file, xvalues, yvalues, points, walls; rounddigits = nothing, generatelines = true)
    xx = define_values("x", xvalues, rounddigits)
    yy = define_values("y", yvalues, rounddigits)
    pp = define_points(points, xvalues, yvalues, rounddigits, generatelines)
    walls = define_walls(walls, rounddigits)

    open(file, "w") do io
        println(io, :(import Pkg))
        println(io, :(Pkg.add(Pkg.PackageSpec(name = "KhepriBase", url = "https://github.com/aptmcl/KhepriBase.jl"))))
        println(io, :(Pkg.add(Pkg.PackageSpec(name = "KhepriBlender", url = "https://github.com/aptmcl/KhepriBlender.jl"))))
        println(io, "##\n")

        println(io, :(using KhepriBlender: xy, delete_all_shapes))
        println(io, :(include("OutAux.jl")))

        if generatelines
            for x in xx
                println(io, x)
            end
            println(io)

            for y in yy
                println(io, y)
            end
            println(io)
        end

        for p in pp
            println(io, p)
        end
        println(io, "\n##\n")

        println(io, :(delete_all_shapes()))
        println(io)

        for wall in walls
            println(io, wall)
        end
        println(io, "\n##\n")

        if generatelines
            println(io, :(show_x_lines([n for n in names(Main) if startswith(string(n), "x")])))
            println(io, :(show_y_lines([n for n in names(Main) if startswith(string(n), "y")])))
        end
        println(io, :(show_points([n for n in names(Main) if startswith(string(n), "p")])))
    end
end
