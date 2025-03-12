% 2024-9-8-2:00
function [w_best,sol_best] = question3_SA(canshu,path)
%QUESTION3_SA 此函数用于完成模拟退火过程
%   此处显示详细说明
    w = -inf;
    
    for j=1:100 %求较好的初始解
        x01 = rand(1,8);
        x02 = rand(1,3);
        x03 = rand;
        b01 = rand(1,3);
        b02 = rand;
        x0 = {x01;x02;x03};
        b0 = {b01;b02};
        sol0= {x0;b0};
        w_temp = question3_profit(2,8,x0,b0,canshu,path);
        if w_temp>w
            plan = sol0; w = w_temp;
        end
    end
    sol_best = plan;
    w_best = w;
    
    
    % fprintf('模拟退火当前最优解是：%f \n',w);
    % disp('此时路径为：')
    % disp(plan);
    % 开始模拟退火过程
    e=0.1^100;L=100000;at=0.9999;T=1;
    for k=1:L  %退火过程
        c = [randi(8) randi(3) rand randi(3) rand];  %产生新解
        x_try = plan{1};
        b_try = plan{2};

        x1 = x_try{1};
        x2 = x_try{2};
        x3 = x_try{3};

        x1(c(1)) = x1(c(1)) + (2*rand-1)*T;
        if x1(c(1))>1
            x1(c(1)) = 1;
        elseif x1(c(1))<0
            x1(c(1)) = 0;
        end

        x2(c(2)) = x2(c(2)) + (2*rand-1)*T;
        if x2(c(2))>1
            x2(c(2)) = 1;
        elseif x2(c(2))<0
            x2(c(2)) = 0;
        end

        x3 = x3 + (2*c(3)-1)*T;
        if x3>1
            x3 = 1;
        elseif x3<0
            x3 = 0;
        end
        x_try = {x1;x2;x3};
        
        b1 = b_try{1};
        b2 = b_try{2};
        
        b1(c(4)) = b1(c(4)) + (2*rand-1)*T;
        if b1(c(4))>1
            b1(c(4)) = 1;
        elseif b1(c(4))<0
            b1(c(4)) = 0;
        end

        b2 = b2 + (2*c(5)-1)*T;
        if b2>1
            b2 = 1;
        elseif b2<0
            b2 = 0;
        end
        b_try = {b1;b2};
        w_temp = question3_profit(2,8,x_try,b_try,canshu,path);
        df = w-w_temp;
        if df<0 %接受准则
            plan={x_try;b_try}; w=w_temp; % 如果更好，一定接受
        elseif exp(-df/T)>=rand
            plan={x_try;b_try}; w=w_temp; % 如果更差，可能接受
        end
        if w>w_best
            w_best = w;
            sol_best = plan;
        end
        T=T*at;
        if T<e
            break;
        end
    end
end

