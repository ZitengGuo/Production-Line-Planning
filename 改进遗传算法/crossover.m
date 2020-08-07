%% 交叉操作
% 输入：pop：种群  Pc：交叉概率  Mj：禁限表  I：工序数
% 输出：pop：交叉后的种群
%% -----------------------------------------------------------------
function pop = crossover(pop,Pc,Mj,I,M)
for i = 1:2:size(pop,1)-1
    if rand <= Pc
        parent1 = pop(i,:);
        parent2 = pop(i+1,:);
        % 选序
        job = randperm(I,1);
        % 替换
        ind1 = find(parent1==job);   % 父代1中所选工序使用的机器
        ind2 = find(parent2==job);   % 父代2中所选工序使用的机器
        ind = intersect(ind1,ind2);  % 相同机器
        for j = 1:length(ind)
            ind1(ind1==ind(j)) = [];  % 相同机器不操作
            ind2(ind2==ind(j)) = [];  % 相同机器不操作
        end
        job1 = parent1(ind2);  % 记录父代1替换出的工序
        job2 = parent2(ind1);  % 记录父代2替换出的工序
        parent1(ind2) = job;   % 替换所选工序
        parent2(ind1) = job;   % 替换所选工序
        % 填充
        if length(ind1) == length(ind2)
            % 情况1：空缺位等于替换基因个数
            parent1(ind1) = job1;
            parent2(ind2) = job2;
        elseif length(ind1) < length(ind2)
            [parent1,parent2] = adjustment_for_crossover(parent1,ind1,job1,parent2,ind2,job2,Mj);
        else
            [parent2,parent1] = adjustment_for_crossover(parent2,ind2,job2,parent1,ind1,job1,Mj);
        end
        % 修正
        pop(i,:) = repair_for_crossover(M,Mj,parent1);
        pop(i+1,:) = repair_for_crossover(M,Mj,parent2);
    end
end