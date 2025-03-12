clear; 
clc;

%设置次品率和误差精度
p0 = 0.1; 
E = 0.01:0.001:0.08;
alpha_95 = 0.05;
alpha_90 = 0.1;

%计算临界值
z_alpha_95 = norminv(1-alpha_95,0,1);
z_alpha_90 = norminv(1-alpha_90,0,1);

%计算最小样本量
n_95 = z_alpha_95^2*p0*(1-p0)./E.^2;
n_90 = z_alpha_90^2*p0*(1-p0)./E.^2;
%取整
n_95_integer = round(n_95);
n_90_integer = round(n_90);

%绘制样本量与允许误差的趋势图
plot(E, n_90_integer, 'r-', 'LineWidth', 1, 'DisplayName', '信度为90%');
hold on
plot(E, n_95_integer, 'g-', 'LineWidth', 1, 'DisplayName', '信度为95%');
% 设置图例、标题和坐标轴标签  
legend show;  
title('不同抽样误差下的最小样本量趋势图','FontSize',8,'FontWeight','bold');  
xlabel('允许抽样误差','FontSize',8);  
ylabel('最小样本量（单位：个）','FontSize',8);






