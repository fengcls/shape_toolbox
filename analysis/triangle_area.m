function [ A ] = triangle_area( v,f )
% v 3xn
% f 3xm
if size(v,1)~=3
    v = v';
end;

if size(f,1)~=3
    f = f';
end;

for kf = 1:length(f)
    facek = v(:,f(:,kf));
    % a-1 b-2 c-3
    ab = facek(:,2)-facek(:,1);
    ac = facek(:,3)-facek(:,1);
    ab = squeeze(ab);
    ac = squeeze(ac);
    costheta=sum(ab.*ac)./sum(ab.^2)./sum(ac.^2);
    sintheta=sqrt(1-costheta.^2);
    A(kf) = sum(ab.^2).*sum(ac.^2).*abs(sintheta);
end;
% A = nansum(A);
end

