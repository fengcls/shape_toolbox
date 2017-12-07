function write_mfile_short(filename, vertex, face)

% write_mfile - write Hughe Hoppe .m file.
%
%   [vertex, face, normal, uv, sphparam] = write_mfile(filename, type);
%
%   type can be 'mesh' (for traditional mesh file) or 'gim' (for geometry
%   image file) or 'sph' (for spherical parameterized mesh).
%
%   Copyright (c) 2007 Gabriel Peyre

fid = fopen(filename);
if fid<0
    error('Unable to open file.');
end

if size(vertex,1)==3
	vertex = vertex';
end;

if size(face,1)==3
	face = face';
end;

% write vertices
for k = 1:length(vertex)
	fprintf(fid,'Vertex %d %f %f %f\n',k,vertex(k,1),vertex(k,2),vertex(k,3));
end;

% write faces
for k = 1:length(face)
	fprintf(fid, 'Face %d %d %d %d\n',k,face(k,1),face(k,2),face(k,3));
end;

fclose(fid);