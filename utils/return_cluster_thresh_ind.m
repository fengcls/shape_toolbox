function cluster_thresh_ind = return_cluster_thresh_ind(f_m,v_ind,cluster_thresh)
N = triangulation2adjacency(f_m);

NV = N;clear N;
NV(v_ind==0,:)=0;
NV(:,v_ind==0)=0;
       
% generate graph object from adjacency matrix
G = graph(NV);
% conncomp
bins = conncomp(G);
[N_bins,edges] = histcounts(bins,max(bins));
edges = ceil(edges(1:end-1));
cluster_thresh_ind = ismember(bins,edges(N_bins>cluster_thresh));
