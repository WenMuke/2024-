function range = question4_range()
%QUESTION4_RANGE 返回问题四置信区间
%   此处显示详细说明
    n0 = 10000;
    p0 = [0.05,0.1,0.2];
    E = 0.01;
    Z = norminv(0.99,0,1);
    
    %计算抽样检测的次品率
    x = binornd(n0,p0);
    p_hat = x./n0;
    n = Z^2.*p_hat.*(1-p_hat)/E^2;
    
    %置信区间上下边界值
    lower_bound = p_hat - sqrt(p_hat.*(1-p_hat)/n)*Z;
    upper_bound = p_hat + sqrt(p_hat.*(1-p_hat)/n)*Z;
    
    %从上到下为5%，10%，20%的置信区间
    range = [lower_bound',upper_bound'];
end

