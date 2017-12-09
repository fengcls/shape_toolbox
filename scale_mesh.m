function scale_mesh(filename,scale_factor)
% scale_factor      one-dimensional scale factor
[path,filename_noext,ext] = fileparts(filename);
if strcmp(ext,'.ply')
    [v,f] = read_ply(filename);
elseif strcmp(ext,'.vtk')
    [v,f] = read_vtk(filename);
end;
if size(v,1)<size(v,2)
    v = v';
end;
central_pos_v_mat = ones(size(v,1),1)*mean(v);
new_v = (v-central_pos_v_mat)*scale_factor+central_pos_v_mat;
if strcmp(ext,'.ply')
    write_ply(new_v,f,[path,filename_noext,'_scaled_',num2str(scale_factor),'.ply'])
elseif strcmp(ext,'.vtk')
    vtkwrite_scalar(new_v,f,[path,filename_noext,'_scaled_',num2str(scale_factor),'.vtk'])
end;