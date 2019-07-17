using ViewerGL
GL = ViewerGL
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation

V = [9. 13 15 17 14 13 11 9 7 5 3 0 2 2 5 7 4 12 6 8 3 5 7 8 10 11 10 13 14 13 11 9 7 4 2 12 12; 0 2 4 8 9 10 11 10 9 9 8 6 3 1 0 1 2 10 3 3 5 5 6 5 5 4 2 4 6 7 9 7 7 7 6 7 5]

EV = Array{Int64,1}[[1, 2], [1, 16], [1, 27], [2, 3], [2, 27], [2, 28], [3, 4], [3, 29], [4, 5], [4, 29], [5, 6], [5, 29], [5, 30], [6, 7], [6, 18], [7, 8], [7, 18], [8, 9], [8, 31], [8, 32], [9, 10], [9, 33], [10, 11], [10, 34], [11, 12], [11, 34], [12, 13], [12, 21], [12, 35], [13, 14], [13, 17], [13, 21], [14, 15], [14, 17], [15, 16], [15, 17], [16, 20], [16, 27], [17, 19], [18, 31], [19, 20], [19, 22], [19, 23], [19, 24], [20, 24], [20, 25], [21, 22], [21, 34], [21, 35], [22, 23], [22, 33], [23, 24], [23, 33], [24, 25], [24, 32], [25, 26], [25, 27], [25, 32], [25, 36], [26, 27], [26, 28], [26, 37], [28, 29], [28, 37], [29, 30], [29, 37], [30, 36], [31, 32], [31, 36], [32, 33], [33, 34], [34, 35], [36, 37]]

FV = Array{Int64,1}[[1, 2, 27], [6, 7, 18], [7, 8, 18, 31], [8, 31, 32], [8, 9, 32, 33], [25, 31, 32, 36], [4, 5, 29], [5, 6, 18, 30, 31, 36], [5, 29, 30], [29, 30, 36, 37], [9, 10, 33, 34], [10, 11, 34], [12, 11, 34, 35], [12, 21, 35], [21, 34, 35], [21, 22, 33, 34], [19, 22, 23], [22, 23, 33], [23, 24, 32, 33], [24, 25, 32], [12, 13, 21], [13, 17, 19, 21, 22], [19, 23, 24], [19, 20, 24], [20, 24, 25], [16, 20, 25, 27], [1, 16, 27], [25, 26, 27], [25, 26, 36, 37], [3, 4, 29], [2, 3, 28, 29], [13, 14, 17], [14, 15, 17], [15, 16, 17, 19, 20], [2, 26, 27, 28], [26, 28, 37], [37, 28, 29]]

W = convert(Lar.Points,V')
cop_EW = Lar.lar2cop(EV)
V,copEV,copFE = Lar.Arrangement.planar_arrangement(W,cop_EW)
V = convert(Lar.Points,V')
EV = Lar.cop2lar(copEV)
FE = Lar.cop2lar(copFE)
FV = [collect(Set(cat([EV[e] for e in f]))) for f in FE]
FV = convert(Lar.Cells,FV)


VV = [[k] for k=1:size(V,2)]
model = (V, [VV,EV,FV])::Lar.LARmodel

meshes = GL.numbering(1.)(model, GL.COLORS[1], 0.1)
#push!(meshes, GL.GLFrame)
GL.VIEW(meshes);
