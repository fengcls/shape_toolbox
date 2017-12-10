function flip_vtk(vtkfilename,flipaxis)
[v,f] = read_vtk(vtkfilename);
switch flipaxis
    case 'x'
        v(1,:) = mean(v(1,:))*2-v(1,:);
        f = flipud(f);
        flip_str = 'x';
    case 'y'
        v(2,:) = mean(v(2,:))*2-v(2,:);
        f = flipud(f);
        flip_str = 'y';
    case 'z'
        v(3,:) = mean(v(3,:))*2-v(3,:);
        f = flipud(f);
        flip_str = 'z';
    case {'xy','yx'}
        v(1,:) = mean(v(1,:))*2-v(1,:);
        v(2,:) = mean(v(2,:))*2-v(2,:);
        flip_str = 'xy';
    case {'xz','zx'}
        v(1,:) = mean(v(1,:))*2-v(1,:);
        v(3,:) = mean(v(3,:))*2-v(3,:);
        flip_str = 'xz';
    case {'yz','zy'}
        v(2,:) = mean(v(2,:))*2-v(2,:);
        v(3,:) = mean(v(3,:))*2-v(3,:);
        flip_str = 'yz';
    case {'xyz','yxz','xzy','yzx','zxy','zyx'}
        v(1,:) = mean(v(1,:))*2-v(1,:);
        v(2,:) = mean(v(2,:))*2-v(2,:);
        v(3,:) = mean(v(3,:))*2-v(3,:);
        f = flipud(f);
        flip_str = 'xyz';
end;

vtkwrite_scalar([vtkfilename(1:(end-4)),'_flip_',flip_str,'.vtk'],v,f);

fid_from = fopen(vtkfilename,'r');
if( fid_from==-1 );    error('Can''t open the file.');    return;end

fid_to = fopen([vtkfilename(1:(end-4)),'_flip_',flip_str,'.vtk'],'r+');
if( fid_to==-1 )    error('Can''t open the file.');    return;end

str = fgets(fid_from);   
if ~strcmp(str(3:5), 'vtk');    error('The file is not a valid VTK one.');    end;
str = fgets(fid_from);str = fgets(fid_from);str = fgets(fid_from);str = fgets(fid_from);nvert = sscanf(str,'%*s %d %*s', 1);
% read vertices
[~,cnt] = fscanf(fid_from,'%f %f %f', 3*nvert);
if cnt~=3*nvert;    warning('Problem in reading vertices.');end

str = fgets(fid_to);   
if ~strcmp(str(3:5), 'vtk');    error('The file is not a valid VTK one.');    end;
str = fgets(fid_to);str = fgets(fid_to);str = fgets(fid_to);str = fgets(fid_to);nvert = sscanf(str,'%*s %d %*s', 1);
% read vertices
[~,cnt] = fscanf(fid_to,'%f %f %f', 3*nvert);
if cnt~=3*nvert;    warning('Problem in reading vertices.');end

str_from = fgets(fid_from);info_from = sscanf(str_from,'%c %*s %*s', 1);
while((info_from ~= 'P'));    str_from = fgets(fid_from);    info_from = sscanf(str_from,'%c %*s %*s', 1);end;
nface = sscanf(str_from,'%*s %d %*s', 1);    [~,cnt] = fscanf(fid_from,'%d %d %d %d\n', 4*nface);

str_to = fgets(fid_to);info_to = sscanf(str_to,'%c %*s %*s', 1);
while((info_to ~= 'P'));    str_to = fgets(fid_to);    info_to = sscanf(str_to,'%c %*s %*s', 1);end;
nface = sscanf(str_to,'%*s %d %*s', 1);    [~,cnt] = fscanf(fid_to,'%d %d %d %d\n', 4*nface);

tline = fgets(fid_from);
while ischar(tline)
    fprintf(fid_to,'%s',tline);
    tline = fgets(fid_from);
end
fclose(fid_from);
fclose(fid_to);


% system(['mv tmptmptmp_vtk.vtk ',vtkfilename]);
