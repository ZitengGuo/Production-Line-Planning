%% repair.m子程序
% 输入：m：工序占用的所有机器  Mj：禁限表  job：工序  chrom：个体
% 输出：chrom：修复后的个体  tf：判断是否需要更换job2
%% -----------------------------------------------------------------
function [chrom,tf] = repair_subf(m,Mj,job,chrom)
tf = true;
i = 1;
while i <= length(m)
    if ~isempty(find(Mj{m(i)}==job,1))
        chrom(m(i)) = job;
        break;
    end
    i = i + 1;
end
if i > length(m)
    tf = false;
end