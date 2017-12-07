function [vertex, face] = read_mfile_short(filename)

% read_mfile - read Hughe Hoppe .m file.
%
%   [vertex, face, normal, uv, sphparam] = read_mfile(filename, type);
%
%   type can be 'mesh' (for traditional mesh file) or 'gim' (for geometry
%   image file) or 'sph' (for spherical parameterized mesh).
%
%   Copyright (c) 2007 Gabriel Peyre

fid = fopen(filename);
if fid<0
    error('Unable to open file.');
end

tline = fgetl(fid);
tline(tline==' ')=[];
t1ch = tline(1);
while (t1ch=='#')
    tline0 = fgets(fid);tline=tline0;
    tline(tline==' ')=[];
    t1ch = tline(1);
end
if exist('tline0','var')
A0 = sscanf(tline0,'Vertex %d %f %f %f\n');
end;
A = fscanf(fid, 'Vertex %d %f %f %f\n');
if exist('A0','var')
A = [A0;A];
end;
A = reshape(A, [4, length(A)/4]);
vertex = A(2:4,:);

% read faces
A = fscanf(fid, 'Face %d %d %d %d\n');
A = reshape(A, [4, length(A)/4]);
face = A(2:end,:);

fclose(fid);