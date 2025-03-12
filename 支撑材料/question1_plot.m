% 定义成功概率p和样本量n的数组  
p = 0.5;  
n_values = [200] % 不同的样本量  
  
% 初始化图形  
figure;  
hold on;  
  
% 遍历不同的样本量  
for n = n_values  
    % 计算二项分布的参数  
    x = 0:n; % 成功的次数  
    y_binom = binopdf(x, n, p); % 二项分布的概率质量函数  
      
    % 计算对应正态分布的参数（均值和标准差）  
    mu = n * p;  
    sigma = sqrt(n * p * (1 - p));  
    x_normal = min(x):(max(x)-min(x))/100:max(x); % 为正态分布创建更平滑的x轴  
    y_normal = normpdf(x_normal, mu, sigma); % 正态分布的概率密度函数  
      
    % 绘制二项分布  
    bar(x, y_binom, 'DisplayName', sprintf('二项分布'));  
      
    % 绘制正态分布  
    plot(x_normal, y_normal, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('正态分布'));  
end  
  
% 设置图例、标题和坐标轴标签  
legend show;  
% axis square
title('二项分布与正态分布的近似');  
xlabel('样本数量n=200');  
ylabel('概率');  
  

  
hold off;