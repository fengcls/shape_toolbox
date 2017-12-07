function write_mfile(filename, type, vertex, face, normal, uv, sphparam)

% write_mfile - write Hughe Hoppe .m file.
%
%   [vertex, face, normal, uv, sphparam] = write_mfile(filename, type);
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
		for k = 1:length(vertex)
		if exist('normal','var')
			if exist('uv','var')
			fprintf(fid, 'Vertex %d %f %f %f {normal=(%f %f %f) uv=(%f %f)}\n',...
				k,vertex(k,1),vertex(k,2),vertex(k,3),...
				normal(k,1),normal(k,2),normal(k,3),...
				uv(k,1),uv(k,2)
				);
			else
			fprintf(fid, 'Vertex %d %f %f %f {normal=(%f %f %f)}\n',...
				k,vertex(k,1),vertex(k,2),vertex(k,3),...
				normal(k,1),normal(k,2),normal(k,3))
			end;
			else
			fprintf(fid, 'Vertex %d %f %f %f\n',...
				k,vertex(k,1),vertex(k,2),vertex(k,3))
			end;
		end;
    case 'sph'
        for k = 1:length(vertex)
		fprintf(fid, 'Vertex %d  %f %f %f {normal=(%f %f %f) sph=(%f %f %f) uv=(%f %f)}\n',...
		k,vertex(k,1),vertex(k,2),vertex(k,3),...
				normal(k,1),normal(k,2),normal(k,3),...
				sphparam(k,1),sphparam(k,2),sphparam(k,3),...
				uv(k,1),uv(k,2));
        end;
    otherwise
        error('Unknown format');
end
% write faces
for k = 1:length(face)
	fprintf(fid, 'Face %d %d %d %d\n',k,face(k,1),face(k,2),face(k,3));
end;
fclose(fid);