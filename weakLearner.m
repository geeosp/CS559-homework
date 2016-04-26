function [minerr,minh,minthres] = weakLearner(axiss,data,lbl,steps,weight)

    if strcmp(axiss,'x')
        mode = 1;
    elseif strcmp(axiss,'y')
        mode = 2;
    elseif strcmp(axiss, 'z')
        mode = 3;
    else
        return;
    end

    maxy = max(data(:,mode));
    miny = min(data(:,mode));
    
    thres = miny : (maxy-miny)/steps : maxy;

    for i = 1:length(thres)     
       idx = data(:,mode) >= thres(i);
       idx = double(idx);
       idx(idx==0) = -1;
%        err = exp(-idx.*lbl);
       err = sum(idx~=lbl)/length(data);
       tempeps(1,:) = sum(weight.*err);
       temph(1,:) = idx';
    
       idx = data(:,mode) < thres(i);
       idx = double(idx);
       idx(idx==0) = -1;
%        err = exp(-idx.*lbl);
       err = sum(idx~=lbl)/length(data);
       tempeps(2,:) = sum(weight.*err);
       temph(2,:) = idx';
       
       [~,minidx] = min(tempeps);
       eps(i,:) = tempeps(minidx,:);
       h(i,:) = temph(minidx,:);
    end
 
    [minerr,minidx2] = min(eps);
    minh = h(minidx2,:)';
    minthres = thres(minidx2);
     
%     figure, scatter(data(lbl<0,1), data(lbl<0,2), '*', 'r');
%     hold on; scatter(data(lbl>0,1), data(lbl>0,2), '*', 'b');
%     grid on; axis equal;
%     if mode == 1
%         yy = min(data(:,1))-1:max(data(:,1))+1;
%         xx = repmat(thres(minidx2),1,size(yy,2)); 
%     else
%         xx = min(data(:,1))-1:max(data(:,1))+1;
%         yy = repmat(thres(minidx2),1,size(xx,2));
%     end
%     hold on, plot(xx,yy);
    
end