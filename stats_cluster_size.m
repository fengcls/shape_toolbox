function table_stats_cluster_size = stats_cluster_size(f_m,v_ind)
%  A = triangulation2adjacency(f);
%  keep_ind = [];
%  for k = 1:length(v_ind)
%      if sum(v_ind(A(:,k)==1))>0
%         keep_ind = [keep_ind,k];
%      end;
%  end;
%
%  if isempty(keep_ind)
%      cluster_size_max = 0;
%      return;
%  end;

N = triangulation2adjacency(f_m);
% % convert to pairs
% f_m_2 = [f_m(1:2,:) f_m([1,3],:) f_m(2:3,:)];
% % distribute the pairs onto a matrix
% N = hist3(f_m_2',max(f_m_2(:))*ones(1,2));
% % undirected symmetric, this is the Adjacency matrix of the original mesh
% N = (N+N')>0;
% only keep certain vertices (row, column)

NV = N;clear N;
NV(v_ind==0,:)=0;
NV(:,v_ind==0)=0;
       
% generate graph object from adjacency matrix
G = graph(NV);
% conncomp
bins = conncomp(G);
[N_bins,~] = histcounts(bins,max(bins));
table_stats_cluster_size(:,1) = 1:max(N_bins);
[table_stats_cluster_size(:,2),~]= histcounts(N_bins,max(N_bins));