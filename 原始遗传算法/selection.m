%% 选择操作
% 输入：pop：种群  s：精英个数  Z：适应度值  pop_size：种群规模  M：机器数
% 输出：pop1：精英组  pop2：普通组  Z1：精英组适应度值  Z2：普通组适应度值
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