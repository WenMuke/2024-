clear,clc;
A = [0.1 4 2 0.1 18 3 0.1 6 3 56 6 5
 0.2 4 2 0.2 18 3 0.2 6 3 56 6 5
 0.1 4 2 0.1 18 3 0.1 6 3 56 30 5
 0.2 4 1 0.2 18 1 0.2 6 2 56 30 5
 0.1 4 8 0.2 18 1 0.1 6 2 56 10 5
 0.05 4 2 0.05 18 3 0.05 6 3 56 10 40];

c_cir = cell(6,2);
disp('遍历结果寻找最佳：')
for check = 1:size(A,1)
    w = -inf;
    p = -ones(1,4);
    lingpeijian = [A(check,1:3);A(check,4:6)];
    chengpin = A(check,7:10);
    buhege = A(check,11:12);
    for x1 = 0:0.01:1
        for x2 = 0:0.01:1
            for x3 = 0:0.01:1
                for x4 = 0:0.01:1

                    w_temp = question2_profit([x1,x2,x3,x4],lingpeijian,chengpin,buhege);
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
    err_q2 = pdist([c_SA{i,2};c_cir{i,2}],"euclidean");
    fprintf('情况%f 的最优解欧氏距离误差率是%f ，最优利润误差率是%f \n',i,err_q2/norm(c_cir{i,2}),abs(c_cir{i,1}-c_SA{i,1})/c_cir{i,1});
end
format short
