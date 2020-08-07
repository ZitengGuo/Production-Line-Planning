%% 选择操作
% 输入：pop：种群  s：精英个数  Z：适应度值  pop_size：种群规模  M：机器数
% 输出：pop1：精英组  pop2：普通组  Z1：精英组适应度值  Z2：普通组适应度值
%% -----------------------------------------------------------------
function [pop1,Z1,B1,pop2] = selection(pop,Z,B,s,pop_size,M)
% 选择精英组
[~,ind] = sort(Z);
pop1 = pop(ind(1:s),:);
Z1 = Z(ind(1:s));
B1 = B(ind(1:s),:);
% 选择普通组
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