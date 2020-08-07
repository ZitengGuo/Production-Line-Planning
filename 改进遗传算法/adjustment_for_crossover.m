%% 交叉操作第三步：填充
% 输入：parent1，2：父代1，2  ind1,ind2：所选工序使用的机器
%       job1,2：替换出的工序集  Mj：禁限表 
% 输出：调整后的父代1，2
%% -----------------------------------------------------------------
function [parent1,parent2] = adjustment_for_crossover(parent1,ind1,job1,parent2,ind2,job2,Mj) 
% 情况2：空缺位小于替换基因个数
parent1(ind1) = job1(1:length(ind1));
% 情况3：空缺为大于替换基因个数
parent2(ind2(1:length(job2))) = job2;
for j = 1:length(ind2)-length(ind1)
    mj = Mj{ind2(end-j+1)};
    rp = randperm(length(mj),1);
    parent2(ind2(end-j+1)) = mj(rp);
end