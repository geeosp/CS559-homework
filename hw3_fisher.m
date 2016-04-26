function [y1,y2,v] = hw3_fisher(c1,c2)

    % compute the mean for each class
    mu1 = mean(c1);
    mu2 = mean(c2);
    
    % compute scatter matrices S1 and S2 for each class
    d1 = c1 - repmat(mu1,length(c1),1);
    d2 = c2 - repmat(mu2,length(c2),1);
    s1 = d1'*d1;
    s2 = d2'*d2;
    
    % within class scatter Sw
    sw = s1+s2;
        
    % get the optimal line direction
    v = inv(sw)*(mu1-mu2)';
    
    y1 = v'*c1';
    y2 = v'*c2';

end

