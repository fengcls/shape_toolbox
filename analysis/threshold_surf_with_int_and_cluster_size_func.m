%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% threshold the scalar of a patch with intensity (first) and cluster size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s = threshold_surf_with_int_and_cluster_size_func(v,f,orig_s,int_thresh,cluster_thresh)
% v                 not really used
% f                 Fx3 matrix specifying the mesh connections
% orig_s            raw scalar
% int_thresh        intensity threshold
% cluster_thresh    cluster threshold

v_keep_ind_int_thresh = ones(size(orig_s));
% the specified intensity threshod is larger than the median, keep larger
% part of the distribution
if int_thresh>0 %int_thresh>median(orig_s)
    v_keep_ind_int_thresh(orig_s<int_thresh)=0;
else
    v_keep_ind_int_thresh(orig_s>int_thresh)=0;
end;
s = orig_s;
s(~v_keep_ind_int_thresh) = 0;

% display the max cluster size
cluster_size_max = max_cluster_size(f,v_keep_ind_int_thresh);
disp(['max cluster size:',num2str(cluster_size_max)]);

% table of the statistics the cluster size
table_stats_cluster_size = stats_cluster_size(f,v_keep_ind_int_thresh);

% return the thresholded ind
cluster_thresh_ind = return_cluster_thresh_ind(f,v_keep_ind_int_thresh,cluster_thresh);

s(~cluster_thresh_ind)=0;
end