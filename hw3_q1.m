clear all; 

n = 10000*100;
% n = 1000;

dat = randn(3,n);
m = [1 2 3]';
dat1 = dat + repmat(m,1,n);
dat2 = diag([10 3 1])*dat1;
R = [0.6651 0.7427 0.0775
     0.7395 -0.6696 0.0697
     0.1037 0.0109 0.9946];
dat3 = R*dat2;

mean0 = mean(dat,2);
mean1 = mean(dat1,2);
mean2 = mean(dat2,2);
mean3 = mean(dat3,2);

dat0 = dat - repmat(mean0, 1, n);
dat10 = dat1 - repmat(mean1, 1, n);
dat20 = dat2 - repmat(mean2, 1, n);
dat30 = dat3 - repmat(mean3, 1, n);

cov0 = cov(dat0');
cov1 = cov(dat1');
cov2 = cov(dat2');
cov3 = cov(dat3');

disp('Means: ');
disp([mean0 mean1 mean2 mean3]);

disp('Covariances matrices: ');
disp(cov0)
disp(cov1)
disp(cov2)
disp(cov3)

pca2 = princomp(dat2');
pca3 = princomp(dat3');

[pca3(:,1) R*pca2(:,1)]
sum(sum(abs((pca3(:,1) - R*pca2(:,1)))))

% figure
% scatter3(dat2(1,:), dat2(2,:), dat2(3,:), '.');
% hold on;
% set(gca, 'DataAspectRatio', [1 1 1]);
% 
% for i = 1:3
%     quiver3(0,0,0,pca2(1,i),pca2(2,i),pca2(3,i),10-2*i);
% end
% 
% figure
% scatter3(dat3(1,:), dat3(2,:), dat3(3,:), '.');
% hold on;
% set(gca, 'DataAspectRatio', [1 1 1]);
% 
% for i = 1:3
%     quiver3(0,0,0,pca3(1,i),pca3(2,i),pca3(3,i),10-2*i);
% end

