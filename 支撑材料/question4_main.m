clear;clc
range = question4_range;

A = [0.1 4 2 0.1 18 3 0.1 6 3 56 6 5
 0.2 4 2 0.2 18 3 0.2 6 3 56 6 5
 0.1 4 2 0.1 18 3 0.1 6 3 56 30 5
 0.2 4 1 0.2 18 1 0.2 6 2 56 30 5
 0.1 4 8 0.2 18 1 0.1 6 2 56 10 5
 0.05 4 2 0.05 18 3 0.05 6 3 56 10 40];

[n,m] = size(A);
for i = 1:n
    for j = 1:m
        if A(i,j) == 0.05
            A(i,j) = range(1,1) + rand*(range(1,2)-range(1,1));
        elseif A(i,j) == 0.1
            A(i,j) = range(2,1) + rand*(range(2,2)-range(2,1));
        elseif A(i,j) ==0.2
            A(i,j) = range(3,1) + rand*(range(3,2)-range(3,1));
        end
    end
end
disp('将所有次品率替换为一个随机的参数，重新给出所有参数：')
disp(A);

c_cir = cell(6,2);
disp('遍历结果寻找最佳：')
for check = 1:size(A,1)
    w = -inf;
    p = -ones(1,4);
    lingpeijian = [A(check,1:3);A(check,4:6)];
    chengpin = A(check,7:10);
    buhege = A(check,11:12);
    for x1 = 0:0.02:1
        for x2 = 0:0.02:1
            for x3 = 0:0.02:1
                for x4 = 0:0.02:1
                    w_temp = question2_profit([x1,x2,x3,x4],...
                        lingpeijian,chengpin,buhege);
                    if w_temp>w
                        w = w_temp;
                        p = [x1,x2,x3,x4];
                    end
                end
            end
        end
    end
    fprintf('情况%f 的最佳期望利润为%f ,最优结果是：',check,w);
    disp(p);
    c_cir{check,1} = w;
    c_cir{check,2} = p;
end

c_SA = cell(6,2);
disp('模拟退火方法：')
for check = 1:size(A,1)
    % check = 1;
    lingpeijian = [A(check,1:3);A(check,4:6)];
    chengpin = A(check,7:10);
    buhege = A(check,11:12);
    [w,p]=question2_SA(lingpeijian,chengpin,buhege);
    fprintf('情况%f 的最佳期望利润为%f ,最优结果是：',check,w);
    disp(p);
    c_SA{check,1} = w;
    c_SA{check,2} = p;
end

d = zeros(1,6);
format longE
for i = 1:6
    err1 = pdist([c_SA{i,2};c_cir{i,2}],"euclidean");
    fprintf(['情况%f 的最优解欧氏距离误差率是%f ，最优利润误差率' ...
        '是%f \n'],i,err1/norm(c_cir{i,2}),...
        abs(c_cir{i,1}-c_SA{i,1})/c_cir{i,1});
end
format short

clear;
range = question4_range;
y_biaozhun = [15.805 6.040 14.431 8.160 12.272 18.586750];

A = [0.1 4 2 0.1 18 3 0.1 6 3 56 6 5
 0.2 4 2 0.2 18 3 0.2 6 3 56 6 5
 0.1 4 2 0.1 18 3 0.1 6 3 56 30 5
 0.2 4 1 0.2 18 1 0.2 6 2 56 30 5
 0.1 4 8 0.2 18 1 0.1 6 2 56 10 5
 0.05 4 2 0.05 18 3 0.05 6 3 56 10 40];
x1 = linspace(range(1,1),range(1,2),100);
x2 = linspace(range(2,1),range(2,2),100);
x3 = linspace(range(3,1),range(3,2));

% 情况1
check = 1;
lingpeijian = [A(check,1:3);A(check,4:6)];
chengpin = A(check,7:10);
buhege = A(check,11:12);
w = zeros(1,100);

for i = 1:100 
    lingpeijian(1,1) = x2(i); % 原始是10%，修改为置信区间的值
    lingpeijian(2,1) = x2(i);
    chengpin(1) = x2(i);
    w(i) = question2_SA(lingpeijian,chengpin,buhege);
end
fprintf(['对于情况1在次品率10%% 波动在区间[%f ,%f ]的时候，' ...
    '利润波动区间为[%f ,%f ]'],x2(1),x2(100),min(w),max(w));
fprintf('此时利润期望为：%f元',sum(w)/length(w));
fprintf('当次品率为10%%时，利润为%f元',y_biaozhun(check));

% 情况2
check = 2;
lingpeijian = [A(check,1:3);A(check,4:6)];
chengpin = A(check,7:10);
buhege = A(check,11:12);
w = zeros(1,100);

for i = 1:100 
    lingpeijian(1,1) = x3(i); % 原始是20%，修改为置信区间的值
    lingpeijian(2,1) = x3(i);
    chengpin(1) = x3(i);
    w(i) = question2_SA(lingpeijian,chengpin,buhege);
end
fprintf(['对于情况2在次品率20%% 波动在区间[%f ,%f ]的时候，' ...
    '利润波动区间为[%f ,%f ]元'],x3(1),x3(100),min(w),max(w));
fprintf('此时利润期望为：%f元',sum(w)/length(w));
fprintf('当次品率为20%%时，利润为%f元',y_biaozhun(check));

% 情况3
check = 3;
lingpeijian = [A(check,1:3);A(check,4:6)];
chengpin = A(check,7:10);
buhege = A(check,11:12);
w = zeros(1,100);

for i = 1:100 
    lingpeijian(1,1) = x2(i); % 原始是10%，修改为置信区间的值
    lingpeijian(2,1) = x2(i);
    chengpin(1) = x2(i);
    w(i) = question2_SA(lingpeijian,chengpin,buhege);
end
fprintf(['对于情况3在次品率10%% 波动在区间[%f ,%f ]的时候，' ...
    '利润波动区间为[%f ,%f ]'],x2(1),x2(100),min(w),max(w));
fprintf('此时利润期望为：%f元',sum(w)/length(w));
fprintf('当次品率为10%%时，利润为%f元',y_biaozhun(check));

% 情况5
check = 5;
lingpeijian = [A(check,1:3);A(check,4:6)];
chengpin = A(check,7:10);
buhege = A(check,11:12);
w = zeros(1,100);

for i = 1:100 
    lingpeijian(1,1) = x2(i); % 原始是10%，修改为置信区间的值
    lingpeijian(2,1) = x3(i);
    chengpin(1) = x2(i);
    w(i) = question2_SA(lingpeijian,chengpin,buhege);
end
fprintf(['对于情况5在次品率10%% 波动在区间[%f ,%f ]，次品率20%% ' ...
    '波动在区间[%f ,%f ]的时候，利润波动区间为[%f ,%f ]'],...
    x2(1),x2(100),x3(1),x3(2),min(w),max(w));
fprintf('此时利润期望为：%f元',sum(w)/length(w));
fprintf('当次品率不波动时，利润为%f元',y_biaozhun(check));

% 情况6
check = 6;
lingpeijian = [A(check,1:3);A(check,4:6)];
chengpin = A(check,7:10);
buhege = A(check,11:12);
w = zeros(1,100);

for i = 1:100 
    lingpeijian(1,1) = x1(i); % 原始是10%，修改为置信区间的值
    lingpeijian(2,1) = x1(i);
    chengpin(1) = x1(i);
    w(i) = question2_SA(lingpeijian,chengpin,buhege);
end
fprintf(['对于情况6在次品率5%% 波动在区间[%f ,%f ]的时候，' ...
    '利润波动区间为[%f ,%f ]'],x1(1),x1(100),min(w),max(w));
fprintf('此时利润期望为：%f元',sum(w)/length(w));
fprintf('当次品率为5%%时，利润为%f元',y_biaozhun(check));

% 单独分析情况4
check = 4;
lingpeijian = [A(check,1:3);A(check,4:6)];
chengpin = A(check,7:10);
buhege = A(check,11:12);
w = zeros(1,100);
% p_rand1 = range(3,1) + rand*(range(3,2)-range(3,1));
p_rand1 = range(3,1);
% p_rand2 = range(3,1) + rand*(range(3,2)-range(3,1));
p_rand2 = range(3,2);
p_rand3 = range(3,1) + rand*(range(3,2)-range(3,1));
lingpeijian(1,1)=p_rand1;
lingpeijian(2,1)=p_rand2;
chengpin(chengpin==0.2)=p_rand3;
fprintf(['当零配件1的次品率更改为%f，零配件2的次品率更改为%f，' ...
    '成品的次品率更改为%f时：'],p_rand1,p_rand2,p_rand3);

% 改变零配件1检测率的情况：
x_plot = linspace(0.8,1,1000);
x_sol = [1 1 1 1];
w_plot = zeros(1,length(x_plot));
for i = 1:length(x_plot)
    x_sol(1) = x_plot(i);
    w_plot(i) = question2_profit(x_sol,lingpeijian,chengpin,buhege);
end
figure;
plot(100*x_plot,w_plot,DisplayName='遍历结果');
title('情况4利润随着零件1检测比例的变化')
xlabel('零件1检测比例(%)')
ylabel('利润')
grid on
legend show
legend Location best
% 改变零配件2检测率的情况：
x_plot = linspace(0.8,1,1000);
x_sol = [1 1 1 1];
w_plot = zeros(1,length(x_plot));
for i = 1:length(x_plot)
    x_sol(2) = x_plot(i);
    w_plot(i) = question2_profit(x_sol,lingpeijian,chengpin,buhege);
end
figure;
plot(100*x_plot,w_plot,DisplayName='遍历结果');
title('情况4利润随着零件2检测比例的变化')
xlabel('零件2检测比例(%)')
ylabel('利润')
grid on
legend show
legend Location best

% 重做问题三
clear;
range = question4_range;
p = range(2,:);
lingpeijian = [
    0.1 2 1
    0.1 8 1
    0.1 12 2
    0.1 2 1
    0.1 8 1
    0.1 12 2
    0.1 8 1
    0.1 12 2
    ];
banchengpin = [
    0.1 8 4 6
    0.1 8 4 6
    0.1 8 4 6
    ];
chengpin = [0.1 8 6 4];
sell_change = [200 40];
for i = 1:8
    lingpeijian(i,1) = range(1) + rand*(range(2)-range(1));
end
for i = 1:3
    banchengpin(i,1) = range(1) + rand*(range(2)-range(1));
end
chengpin(1) = range(1) + rand*(range(2)-range(1));
parameter = {lingpeijian;banchengpin;chengpin;sell_change};
hechenglujing = {[3 3 2];3};
plan = cell(2,1);

[w, sol] = question3_SA(parameter,hechenglujing);
x_sol = sol{1};
b_sol = sol{2};
fprintf('根据题目条件，最佳的利润为：%f\n',w);
for i = 1:3
    x_temp = x_sol{i};
    for j = 1:length(x_temp)
        if x_temp(j) == 0
            fprintf('流程%f 的第 %f 个零配件/半成品/成品不检测\n',i,j);
        elseif x_temp(j) == 1
            fprintf('流程%f 的第 %f 个零配件/半成品/成品全部检测\n',i,j);
        else
            fprintf(['流程%f 的第 %f 个零配件/半成品/成品应当有' ...
                '%f %% 检测\n'],i,j,100*x_temp(j));
        end
    end
end
for i = 1:2
    b_temp = b_sol{i};
    for j = 1:length(b_temp)
        if b_temp(j) == 0
            fprintf('流程%f 的第 %f 个半成品/成品不拆解\n',i+1,j);
        elseif b_temp(j) == 1
            fprintf('流程%f 的第 %f 个半成品/成品全部拆解\n',i+1,j);
        else
            fprintf('流程%f 的第 %f 个半成品/成品应当有%f %% 拆解\n',...
                i+1,j,100*b_temp(j));
        end
    end
end

% 遍历检验
w_best = -inf;
sol=cell(2,1);
for x11 = 0:1
for x12 = 0:1
for x13 = 0:1
for x14 = 0:1
for x15 = 0:1
for x16 = 0:1
for x17 = 0:1
for x18 = 0:1
x_sol1 = [x11 x12 x13 x14 x15 x16 x17 x18];
for x21 = 0:1
for x22 = 0:1
for x23 = 0:1
x_sol2 = [x21 x22 x23];
for x31 = 0:1
x_sol_try = {x_sol1;x_sol2;x31};
for b21 = 0:1
for b22 = 0:1
for b23 = 0:1
b_sol1 = [b21,b22,b23];
for b31 = 0:1
    b_sol_try = {b_sol1;b31};
    w_try = question3_profit(2,8,x_sol_try,b_sol_try,...
        parameter,hechenglujing);
    if w_try>w_best
        w_best = w_try;
        sol_best = {x_sol_try;b_sol_try};
    end

end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end


w_best_bianli = w_best;
sol_best_bianli = sol_best;
x_sol_bianli = sol_best_bianli{1};
b_sol_bianli = sol_best_bianli{2};
fprintf('根据题目条件，最佳的利润为：%f\n',w_best_bianli);
for i = 1:3
    x_temp = x_sol_bianli{i};
    for j = 1:length(x_temp)
        if x_temp(j) == 0
            fprintf('流程%f 的第 %f 个零配件/半成品/成品不检测\n',i,j);
        elseif x_temp(j) == 1
            fprintf('流程%f 的第 %f 个零配件/半成品/成品全部检测\n',i,j);
        else
            fprintf(['流程%f 的第 %f 个零配件/半成品/成品应当有' ...
                '%f %% 检测\n'],i,j,100*x_temp(j));
        end
    end
end
for i = 1:2
    b_temp = b_sol_bianli{i};
    for j = 1:length(b_temp)
        if b_temp(j) == 0
            fprintf('流程%f 的第 %f 个半成品/成品不拆解\n',i+1,j);
        elseif b_temp(j) == 1
            fprintf('流程%f 的第 %f 个半成品/成品全部拆解\n',i+1,j);
        else
            fprintf(['流程%f 的第 %f 个半成品/成品应当有' ...
                '%f %% 拆解\n'],i+1,j,100*b_temp(j));
        end
    end
end
