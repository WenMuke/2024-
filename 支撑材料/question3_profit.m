function w = question3_profit(m,n,x,b,canshu,path) % path 表示合成路径
%QUESTION3_PROFIT 输入相关参数，返回利润
%   m表示工序，n表示零配件数量
%   x表示每一步的检测
%   b表示每一步的拆解率
    m_check = size(canshu,1);
    if m_check ~= m+2
        error('工序和参数数量不对应，请检查每一步的零配件半成品成品参数是否正确输入');
    end
    if sum(path{1}) ~= n
        disp(canshu{1});
        disp(sum(canshu{1}));
        error('零件数量和合成步骤不对应，请重新检查');
    end
    % 对cell进行拆解
    x1 = x{1}; % 零配件检测
    x2 = x{2}; % 半成品检测
    x3 = x{3}; % 成品检测
    b2 = b{1}; % 半成品拆解
    b3 = b{2}; % 成品拆解
    lingpeijian = canshu{1};
    banchengping = canshu{2};
    chengpin = canshu{3};
    sell_change = canshu{4};

    p11 = lingpeijian(1,1);
    p12 = lingpeijian(2,1);
    p13 = lingpeijian(3,1);
    p14 = lingpeijian(4,1);
    p15 = lingpeijian(5,1);
    p16 = lingpeijian(6,1);
    p17 = lingpeijian(7,1);
    p18 = lingpeijian(8,1);
    
    % 开始计算中间变量    
    p11_3 = (1-x1(1))*p11;
    p12_3 = (1-x1(2))*p12;
    p13_3 = (1-x1(3))*p13;
    p14_3 = (1-x1(4))*p14;
    p15_3 = (1-x1(5))*p15;
    p16_3 = (1-x1(6))*p16;
    p17_3 = (1-x1(7))*p17;
    p18_3 = (1-x1(8))*p18;    

    a1 = 1-x1(1)*p11;
    a2 = 1-x1(2)*p12;
    a3 = 1-x1(3)*p13;
    a4 = 1-x1(4)*p14;
    a5 = 1-x1(5)*p15;
    a6 = 1-x1(6)*p16;
    a7 = 1-x1(7)*p17;
    a8 = 1-x1(8)*p18;

    p21_2 = 1-(1-p11_3)*(1-p12_3)*(1-p13_3)*(1-banchengping(1,1));
    p22_2 = 1-(1-p14_3)*(1-p15_3)*(1-p16_3)*(1-banchengping(2,1));
    p23_2 = 1-(1-p17_3)*(1-p18_3)*(1-banchengping(3,1));

    p21_3 = (1- x2(1))*p21_2/(1-x2(1)*p21_2);
    p22_3 = (1- x2(2))*p22_2/(1-x2(2)*p22_2);
    p23_3 = (1- x2(3))*p23_2/(1-x2(3)*p23_2);
    
    n1 = min([a1,a2,a3]);
    n2 = min([a4,a5,a6]);
    n3 = min([a7,a8]);

    a9 = n1-n1*x2(1)*p21_2;
    a10 = n2-n2*x2(2)*p22_2;
    a11 = n3-n3*x2(3)*p23_2;

    n4 = min([a9,a10,a11]);
    n5 = n1*x2(1)*p21_2*b2(1);
    n6 = n1*x2(2)*p22_2*b2(2);
    n7 = n1*x2(3)*p23_2*b2(3);

    p31_2 = 1-(1-p21_3)*(1-p22_3)*(1-p23_3)*(1-chengpin(1));
    p31_3 = ((1-x3)*p31_2)/(1-x3*p31_2);
    
    a12 = n4-n4*p31_2*x3;

    n8 = n4*p31_2*x3*b3;
    n9 = a12*(1-p31_3);
    n10 = a12*p31_3;
    n11 = a12*p31_3*b3;
    
    % k = whos

     
    w = sell_change(1)*n9 ... % 销售额
        - sum(lingpeijian(:,2))... % 零件成本
        - x1*(lingpeijian(:,3))... % 检测零件成本，矩阵乘法
        - [n1,n2,n3] * banchengping(:,2) ... % 半成品组装成本，矩阵乘法
        - ([n1,n2,n3].*x2)  * banchengping(:,3) ... % 半成品检测成本
        - [n5,n6,n7] * banchengping(:,4) ... % 不合格半成品拆卸
        + [n5,n6,n7] * [sum(lingpeijian(1:3,2)); sum(lingpeijian(4:6,2)); sum(lingpeijian(7:8,2))]... % 不合格半成品拆卸收益
        - n4 * chengpin(2)... % 成品组装成本
        - n4 * x3 * chengpin(3) ... % 成品检测成本
        - (n8+n11) * chengpin(4) ... % 成品不合格拆卸
        - n10 * sell_change(2)... % 调换损失
        + sum(lingpeijian(:,2))*(n8+n11) ... % 不合格成品拆卸产生收益
        ;

end

