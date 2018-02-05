function shift_vtk(vtkfilename,shift)
[v,f] = read_vtk(vtkfilename);
if length(shift)~=3
    warning('please specify [x y z] shift vector');
elseif size(shift,2)==3
    shift = shift';
end;
v = v - shift*ones(1,size(v,2));
vtkwrite_scalar([vtkfilename(1:(end-4)),sprintf('_shift_x%0.1fy%0.1fz%0.1f',shift),'.vtk'],v,f);

