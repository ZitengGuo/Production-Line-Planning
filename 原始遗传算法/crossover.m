%% 交叉操作
% 输入：pop：种群  Pc：交叉概率  Mj：禁限表  I：工序数
% 输出：pop：交叉后的种群
%% -----------------------------------------------------------------
function pop = crossover(pop,Pc,Mj,M)
for i = 1:2:size(pop,1)-1
    if rand <= Pc
        job = randperm(M,2); % 随机选择两台不同机器
        job = sort(job);     % 机器号从小到大排序
        % 交叉两点之间的基因段
        tmp = pop(i,job);
        pop(i,job) = pop(i+1,job);
        pop(i+1,job) = tmp;
        % 修正
        pop(i,:) = repair_for_crossover(M,Mj,pop(i,:));
        pop(i+1,:) = repair_for_crossover(M,Mj,pop(i+1,:));
    end
end