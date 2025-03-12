clear,clc
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

parameter = {lingpeijian;banchengpin;chengpin;sell_change};
hechenglujing = {[3 3 2];3};
plan = cell(2,1);

[w, sol] = question3_SA(parameter,hechenglujing);
x_sol = sol{1}
b_sol = sol{2}
fprintf('根据题目条件，最佳的利润为：%f\n',w);
for i = 1:3
    x_temp = x_sol{i};
    for j = 1:length(x_temp)
        if x_temp(j) == 0
            fprintf('流程%f 的第 %f 个零配件不检测\n',i,j);
        elseif x_temp(j) == 1
            fprintf('流程%f 的第 %f 个零配件全部检测\n',i,j);
        else
            fprintf('流程%f 的第 %f 个零配件应当有%f %% 检测\n',i,j,...
                100*x_temp(j));
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
            fprintf('流程%f 的第 %f 个零配件应当有%f %% 拆解\n',i+1,j,...
                100*b_temp(j));
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
w_try = question3_profit(2,8,x_sol_try,b_sol_try,parameter,hechenglujing);
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
            fprintf('流程%f 的第 %f 个零配件不检测\n',i,j);
        elseif x_temp(j) == 1
            fprintf('流程%f 的第 %f 个零配件全部检测\n',i,j);
        else
            fprintf('流程%f 的第 %f 个零配件应当有%f %% 检测\n',i,j,...
                100*x_temp(j));
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
            fprintf('流程%f 的第 %f 个零配件应当有%f %% 拆解\n',...
                i+1,j,100*b_temp(j));
        end
    end
end

err_q3 = pdist([x_sol{1},x_sol{2},x_sol{3},b_sol{1},b_sol{2};...
    x_sol_bianli{1},x_sol_bianli{2},x_sol_bianli{3},b_sol_bianli{1},...
    b_sol_bianli{2}],"euclidean");

fprintf('最优解欧氏距离误差率是%f %%，最优利润误差率是%f %% \n',...
    100*err_q3/norm([x_sol_bianli{1},x_sol_bianli{2},x_sol_bianli{3},...
    b_sol_bianli{1},b_sol_bianli{2}]), 100*abs(w_best_bianli-w)...
    /w_best_bianli);
