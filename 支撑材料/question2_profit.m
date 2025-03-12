function w = question2_profit(x,lingpeijian,chengpin,buhege)
%QUESTION2_PROFIT 输入相关参数，返回利润
%   此处显示详细说明
    c1 = lingpeijian(1,1); % 零配件1次品率
    c2 = lingpeijian(2,1); % 零配件2次品率
    p1 = x(1)*(1-c1)+(1-x(1))*(1-c1);
    p2 = (1-x(1))*c1;
    p3 = x(2)*(1-c2)+(1-x(2))*(1-c2);
    p4 = (1-x(2))*c2;
    % p1_temp = p1/(p1+p2);
    % p2_temp = p2/(p1+p2);
    % p3_temp = p3/(p3+p4);
    % p4_temp = p4/(p3+p4);
    % p1 = p1_temp;
    % p2 = p2_temp;
    % p3 = p3_temp;
    % p4 = p4_temp;
    % if p1+p2~=1
    %     error('p1+p2=1');
    % end

    c3 = (p1*p3*chengpin(1)+p1*p4+p2*p3+p2*p4)/(p1*p3+p1*p4+p2*p3+p2*p4); % 成品修正次品率
    % c3 = (p1_temp*p3_temp*chengpin(1)+p1_temp*p4_temp+p2_temp*p3_temp+p2_temp*p4_temp)...
    %     /(p1_temp*p3_temp+p1_temp*p4_temp+p2_temp*p3_temp+p2_temp*p4_temp);
    % if abs(c3-c3_temp)>0.0001
    %     disp('c3~=c3_check');
    %     disp(x);
    % end
    
    % if c3~=c3_check
    %     error(c3~=c3_check);
    % end

    a1 = x(1)*(1-c1) + (1-x(1));
    a2 = x(2)*(1-c2) + (1-x(2));

    n1 = min(a1,a2); % 进行零件检测后装配成的成品
    n2 = n1 - n1*x(3)*c3; % 进行成品检测后剩余产品（包括没有检测部分）
    n3 = n1*x(3)*c3; % 成品检测不合格品
    n4 = n3*x(4); % 
    n5 = n1*(1-x(3))*c3;
    n6 = n5*x(4);

    w = chengpin(4)*(n2-n5)... % 销售额
        - sum(lingpeijian(:,2))... % 零件成本
        - x(1)*lingpeijian(1,3) - x(2)*lingpeijian(2,3)... % 检测零件成本
        - n1*chengpin(2)... % 成品组装成本
        - x(3)*n1*chengpin(3)... % 成品检测成本
        - buhege(2)*(n4+n6)... % 成品不合格拆卸
        - buhege(1)*n5... % 调换损失
        + sum(lingpeijian(:,2))*(n4+n6) ... % 调换产生收益
        ;
end

