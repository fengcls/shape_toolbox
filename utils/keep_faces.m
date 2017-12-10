function [f_k,v_keep_ind] = keep_faces(f,v_keep_ind)
if size(f,2)==3
    f = f';
end;
f1_ind = ismember(f(1,:),v_keep_ind);
f2_ind = ismember(f(2,:),v_keep_ind);
f3_ind = ismember(f(3,:),v_keep_ind);
f_k = f(:,f1_ind & f2_ind & f3_ind);
f_k_u = unique(f_k);
% collapse the whole list of vertices into those that exist
if length(f_k_u)==length(v_keep_ind)
    for k = 1:length(f_k_u)
        f_k(f_k==f_k_u(k))=k;
    end;
else
    if (length(v_keep_ind)-length(f_k_u))==1
        disp(['there is a singular vertex ',num2str(setdiff(v_keep_ind,f_k_u))]);
    else
        disp('there are singular vertices');
    end;
    v_keep_ind(ismember(v_keep_ind,setdiff(v_keep_ind,f_k_u)))=[];
    f_k = keep_faces(f,v_keep_ind);
end;
