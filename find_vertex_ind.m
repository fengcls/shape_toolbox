function idx = find_vertex_ind(v_all,v_query,dim)
% make the first dimenstion 3/2
if size(v_all,2)==dim
v_all = v_all';
end;
if (size(v_query,2)==dim && size(v_query,1)==dim)
    warndlg('make sure which dimension is vertex');
    pause;
end;
if size(v_query,2)==dim
    v_query = v_query';
end;

[idx,~] = knnsearch(v_all',v_query','K',1);
