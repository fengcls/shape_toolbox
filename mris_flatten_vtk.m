function mris_flatten_vtk(filename,leftright)
% using mris_flatten to flatten a surface in vtk format
[path,filename_noext,ext] = fileparts(filename);
if strcmp(ext,'.vtk')
    [vertex,face] = read_vtk(filename);
elseif strcmp(ext,'.ply')
    [vertex,face] = read_ply(filename);
else
    return;
end;
if size(vertex,1)<size(vertex,2)
    vertex = vertex';
end;
if size(face,1)<size(face,2)
    face = face';
end;

vertex = vertex(1:max(face(:)),:);

if ~exist([path,'/',filename_noext,'_to_flat/'],'dir')
    mkdir([path,'/',filename_noext,'_to_flat/']);
end;
% output a 3D patch format first
patch3dname = [path,'/',filename_noext,'_to_flat/',leftright,'.',filename_noext,'.patch.3d'];
smoothwmname = [path,'/',filename_noext,'_to_flat/',leftright,'.smoothwm'];
patchflatname = [path,'/',filename_noext,'_to_flat/',leftright,'.',filename_noext,'.patch.flat'];

% patch = 
%   struct with fields:
% 
%     npts: 98302
%      ind: [1×98302 double]
%        x: [1×98302 double]
%        y: [1×98302 double]
%        z: [1×98302 double]
%      vno: [1×98302 double] same as ind
p.npts = length(vertex);
p.ind = [1:p.npts]-1;
p.vol = p.ind;
p.x = vertex(:,1);
p.y = vertex(:,2);
p.z = vertex(:,3);

write_patch(patch3dname,p);
write_surf(smoothwmname,vertex,face);

mris_flatten_cmd = ['mris_flatten ',patch3dname,' ',patchflatname];
disp(mris_flatten_cmd);