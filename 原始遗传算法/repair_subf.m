%% repair.m�ӳ���
% ���룺m������ռ�õ����л���  Mj�����ޱ�  job������  chrom������
% �����chrom���޸���ĸ���  tf���ж��Ƿ���Ҫ����job2
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