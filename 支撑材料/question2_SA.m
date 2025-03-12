function [w_best,plan_best] = question2_SA(lingpeijian,chengpin,buhege)
%QUESTION2_SA 此函数用于完成模拟退火过程
%   此处显示详细说明
    w = -inf;
    
    for j=1:100 %求较好的初始解
        plan0= rand(1,4);
        w_temp = question2_profit(plan0,lingpeijian,chengpin,buhege) ;
        if w_temp>w
            plan = plan0; w = w_temp;
        end
    end
    plan_best = plan;
    w_best = w;
    
    
    % fprintf('模拟退火当前最优解是：%f \n',w);
    % disp('此时路径为：')
    % disp(plan);
    % 开始模拟退火过程
    e=0.1^100;L=100000;at=0.9999;T=1;
    for k=1:L  %退火过程
        c=randi(4);  %产生新解
        if rand>=0.5
            plan_try = plan;
            plan_try(c) = rand*T+plan_try(c);
            if plan_try(c)>1
                plan_try(c)=1;
            end
        else
            plan_try = plan;
            plan_try(c) = rand*T-plan_try(c);
            if plan_try(c)<0
                plan_try(c)=0;
            end
        end
        if plan_try(c)>1 || plan_try(c)<0
            disp(plan_try(c));
            error('不在四维单位立方体中');
        end
    
        w_temp = question2_profit(plan_try,lingpeijian,chengpin,buhege) ;
        df = w-w_temp;
        if df<0 %接受准则
            plan=plan_try; w=w_temp; % 如果更好，一定接受
        elseif exp(-df/T)>=rand
            plan=plan_try; w=w_temp; % 如果更差，可能接受
        end
        if w>w_best
            w_best = w;
            plan_best = plan;
        end
        T=T*at;
        if T<e
            break;
        end
    end
end