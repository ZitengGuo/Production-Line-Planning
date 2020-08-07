%% ѡ�����
% ���룺pop����Ⱥ  s����Ӣ����  Z����Ӧ��ֵ  pop_size����Ⱥ��ģ  M��������
% �����pop1����Ӣ��  pop2����ͨ��  Z1����Ӣ����Ӧ��ֵ  Z2����ͨ����Ӧ��ֵ
%% -----------------------------------------------------------------
function parent = selection(pop,Z,pop_size)
parent = pop;
Z = 1./Z;
prob = Z / sum(Z);
prob_cum = cumsum(prob);
for i = 1:pop_size
    ind = find(prob_cum>rand,1);
    parent(i,:) = pop(ind,:);
end