function output_txt = flatten_surf_txt(obj,event_obj)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)]};

% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
end
target_obj = get(event_obj,'Target');
selected_ind = find_vertex_ind(target_obj.Vertices,pos,3);
output_txt{end+1} = ['Val: ',num2str(target_obj.FaceVertexCData(selected_ind),6)];