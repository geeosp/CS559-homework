function data = getRandn(N, mean, var)
    data = mean + sqrt(var).*randn(N,1);
end