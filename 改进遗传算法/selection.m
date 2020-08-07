%% ѡ�����
% ���룺pop����Ⱥ  s����Ӣ����  Z����Ӧ��ֵ  pop_size����Ⱥ��ģ  M��������
% �����pop1����Ӣ��  pop2����ͨ��  Z1����Ӣ����Ӧ��ֵ  Z2����ͨ����Ӧ��ֵ
%% -----------------------------------------------------------------
function [pop1,Z1,B1,pop2] = selection(pop,Z,B,s,pop_size,M)
% ѡ��Ӣ��
[~,ind] = sort(Z);
pop1 = pop(ind(1:s),:);
Z1 = Z(ind(1:s));
B1 = B(ind(1:s),:);
% ѡ����ͨ��
pop2 = zeros(pop_size-s,M);
Z_o = zeros(1,pop_size-s);
Z = 1./Z;
prob = Z / sum(Z);
prob_cum = cumsum(prob);
for i = 1:pop_size-s
    ind = find(prob_cum>rand,1);
    pop2(i,:) = pop(ind,:);
    Z_o(i) = Z(ind);
end