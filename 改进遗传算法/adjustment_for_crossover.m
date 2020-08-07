%% ������������������
% ���룺parent1��2������1��2  ind1,ind2����ѡ����ʹ�õĻ���
%       job1,2���滻���Ĺ���  Mj�����ޱ� 
% �����������ĸ���1��2
%% -----------------------------------------------------------------
function [parent1,parent2] = adjustment_for_crossover(parent1,ind1,job1,parent2,ind2,job2,Mj) 
% ���2����ȱλС���滻�������
parent1(ind1) = job1(1:length(ind1));
% ���3����ȱΪ�����滻�������
parent2(ind2(1:length(job2))) = job2;
for j = 1:length(ind2)-length(ind1)
    mj = Mj{ind2(end-j+1)};
    rp = randperm(length(mj),1);
    parent2(ind2(end-j+1)) = mj(rp);
end