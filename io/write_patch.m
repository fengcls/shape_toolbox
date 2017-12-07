%
% read_patch.m
%
% Original Author: Bruce Fischl
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2013/01/22 20:59:09 $
%    $Revision: 1.3.2.2 $
%
% Copyright Â© 2011 The General Hospital Corporation (Boston, MA) "MGH"
%
% Terms and conditions for use, reproduction, distribution and contribution
% are found in the 'FreeSurfer Software License Agreement' contained
% in the file 'LICENSE' found in the FreeSurfer distribution, and here:
%
% https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense
%
% Reporting: freesurfer@nmr.mgh.harvard.edu
%


function write_patch(fname,patch)
% function patch = read_patch(fname)

% patch = 
%   struct with fields:
% 
%     npts: 98302
%      ind: [1×98302 double]
%        x: [1×98302 double]
%        y: [1×98302 double]
%        z: [1×98302 double]
%      vno: [1×98302 double] same as ind

fid = fopen(fname,'w');
if (fid == -1)
   error('could not open file %s', fname) ;
end
fwrite(fid, -1, 'int', 0, 'b');
fwrite(fid, patch.npts, 'int', 0, 'b') ;

for i=1:patch.npts
    fwrite(fid, patch.ind(i)+1, 'int', 0, 'b') ;
    
    fwrite(fid, patch.x(i), 'float', 0, 'b') ;
    fwrite(fid, patch.y(i), 'float', 0, 'b') ;
    fwrite(fid, patch.z(i), 'float', 0, 'b') ;
end

fclose(fid);
