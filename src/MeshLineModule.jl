"""
    MeshLineModule

Module  for generation of meshes composed of line (curve) elements.
"""
module MeshLineModule

using FinEtools.FTypesModule: FInt, FFlt, FCplxFlt, FFltVec, FIntVec, FFltMat, FIntMat, FMat, FVec, FDataDict
import FinEtools.FENodeSetModule: FENodeSet
import FinEtools.FESetModule: FESetL2, FESetL3

if VERSION >= v"0.7-"
    linspc(start, stop, length)  = range(start, stop = stop, length = length)
else
    linspc(start, stop, length)  = linspace(start, stop, length)  
end

"""
L2block(Length::FFlt, nL::FInt)

Mesh of a 1-D block of L2 finite elements.
"""
function L2block(Length::FFlt, nL::FInt)
    fens,fes = L2blockx(collect(squeeze(linspc(0,Length,nL+1)',1)));
end


"""
L2blockx(xs::FFltVec)

Graded mesh of a 1-D block, L2 finite elements.
"""
function L2blockx(xs::FFltVec)
    xyz =reshape(sort(xs),length(xs),1);
    ncells=length(xs)-1;

    # create the nodes
    fens = FENodeSet(xyz);
    # Create the finite elements
    fes = FESetL2([(1:ncells) (2:ncells+1)]);

    return fens,fes;
end


"""
    L3blockx(xs::FFltVec)

Graded mesh of a 1-D block, L2 finite elements.
"""
function L3blockx(xs::FFltVec)
    fens,fes = L2blockx(xs)
    nxyz = zeros(count(fes), size(fens.xyz, 2))
    nconn = zeros(FInt, count(fes), 3)
    N = count(fens)
    for i = 1:count(fes)
        N = N + 1
        nxyz[i, :] = mean(fens.xyz[[k for k in fes.conn[i]], :], 1)
        nconn[i, :] = vcat([k for k in fes.conn[i]], [N])
    end
    fens = FENodeSet([fens.xyz; nxyz]);
    # Create the finite elements
    fes = FESetL3(nconn);

    return fens,fes;
end


end
