function [vertex, face, normal, uv, sphparam] = read_mfile_u(filename, type)

% read_mfile - read Hughe Hoppe .m file.
%
%   [vertex, face, normal, uv, sphparam] = read_mfile(filename, type);
%
%   type can be 'mesh' (for traditional mesh file) or 'gim' (for geometry
%   image file) or 'sph' (for spherical parameterized mesh).
%
%   Copyright (c) 2007 Gabriel Peyre

if nargin<2
    type = 'mesh';
end

fid = fopen(filename);
if fid<0
    error('Unable to open file.');
end

switch lower(type)
    case {'gim' 'mesh'}
        A = fscanf(fid, 'Vertex %d %f %f %f {u=(%f %f %f)}\n');
        A = reshape(A, [7, length(A)/7]);
        vertex = A(2:4,:);
        u = A(5:7,:);
        sphparam = [];
end
% read faces
A = fscanf(fid, 'Face %d %d %d %d\n');
A = reshape(A, [4, length(A)/4]);
face = A(2:end,:);

fclose(fid);