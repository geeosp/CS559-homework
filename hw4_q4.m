clear all;
data = dlmread('pima-indians-diabetes.data');

x = data(:,2:4);
y = data(:,9); y(y==0) = -1;

len = length(x);

% adaboost
w = repmat(1/len,len,1);
cnt = 1;

for i = ['x' 'y' 'z']
    [eps,h,thres] = weakLearner(i,x,y,50,w);
        
    alpha = .5*log((1-eps)/eps);
  
    w = w.*exp(-alpha.*y.*h);
    w = w/sum(w);  % w/z
    
    finalh(cnt) = thres;
    finalalpha(cnt) = alpha;
    cnt = cnt + 1;
    
    1-eps
end

% % to test:
% % H(x) = 
%     tmp = x > repmat(finalh,len,1);
%     tmp = double(tmp);
%     tmp(tmp==0) = -1;
%     h = sign(sum(tmp.*alpha,2));
%     acc = sum(h==y)/len


