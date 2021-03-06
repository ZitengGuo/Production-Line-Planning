%% 主函数
%% -----------------------------------------------------------------
clear,clc
tic
%% 参数初始化
I = 4;                      % 工序数
M = 13;                     % 机器数
K = 7;                      % 周期数
Tc = 24*60;                 % 每个周期时长（统一单位为min）
Ts = 20;                    % 切换耗时
q0 = 5100;                  % 每个周期到达首工序的物料总数
alpha = 1;                  % 目标函数权重1
beta = 10^4;                % 目标函数权重2
Ti = [50,58,53,55]/60;      % 工序加工时间
W = [2179,1425,3692,2047];  % 初始在制品数量
Lm = 30*60;                 % 单机最大负荷量
Mj = {[2,4],[1,3],[1,4],[1,2,3],[1,3],[3,4],[1,2,4],...
    [2,3],[2,4],[1,3,4],[2,3,4],[2,3,4],[1,2,3,4]};   % 禁限表
w1 = 0.3;                   % 初始化种群比例1
w2 = 0.9;                   % 初始化种群比例2
Pc = 0.8;                   % 交叉概率
Pm = 0.2;                   % 变异概率
s = 10;                     % 精英数量
Iter = 100;                 % 迭代次数
pop_size = 100;              % 种群数量
lbest = zeros(1,Iter);      % 每个周期每次迭代的最优适应度值
gbest = zeros(1,K);         % 每个周期最优适应度值
pop_best = cell(1,K+1);     % 每个周期最优的个体（索引从2开始）
B_best = cell(1,K+1);       % 对应各个周期剩余的在制品数量（索引从2开始）
B_best{1} = W;              % 初始在制品数量
%% 主循环
for k = 1:K
    %% 初始化种群
    pop = initialization(pop_size,I,M,w1,w2,Mj,Ti);
    %% 计算初始种群的适应度值
    [Z,B,pop] = fitness(pop,pop_best{k},B_best{k},I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta);
    for g = 1:Iter
        fprintf('当前周期数|迭代次数：'),disp([num2str(k) '|' num2str(g)])
        %% 选择操作
        [parent1,Z1,B1,parent2] = selection(pop,Z,B,s,pop_size,M);
        %% 交叉操作
        parent2 = crossover(parent2,Pc,Mj,I,M);
        %% 变异操作
        parent2 = mutation(parent2,Pm,Mj,M);
        %% 计算种群适应度
        [Z2,B2,parent2] = fitness(parent2,pop_best{k},B_best{k},I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta);
        %% 合并种群
        pop = [parent1;parent2];
        Z = [Z1,Z2];
        B = [B1;B2];
        %% 获取当代最优适应度值
        lbest(g) = min(Z);
    end
    %% 绘制图形
    subplot(3,3,k)
    plot(1:Iter,lbest)
    %% 记录各个周期最优结果
    [gbest(k),ind] = min(Z);
    pop_best{k+1} = pop(ind,:);
    B_best{k+1} = B(ind,:);
end
Z_total = sum(gbest);   % 适应度总和
toc