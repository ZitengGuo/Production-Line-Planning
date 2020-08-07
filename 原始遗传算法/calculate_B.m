%% 计算工序在制品
% 输入：B：上一周期工序在制品   I：工序数量   
%       chrom：周期k个体   chrom_o：周期(k-1)最优个体
%       Tc：单次平衡时间   Ts：切换耗时   Ti：工序加工时间 
%       q0：每个周期内到达首工序的物料总量
% 输出：B_new：更新后的工序在制品
%% -----------------------------------------------------------------
function B_new = calculate_B(B,I,chrom,chrom_o,Tc,Ts,Ti,q0)
ind = cell(1,I);  % 各工序使用的机器索引
num = zeros(1,I); % 各工序使用的机器数量
for i = 1:I
    ind{i} = find(chrom==i);
    num(i) = length(ind{i});
end
shift = zeros(1,I); % 各工序机器切换次数之和
if ~isempty(chrom_o)
    for i = 1:I
       ii = ind{i};
       shift(i) = length(find(chrom_o(ii)~=i));
    end
end
Q = floor(Tc./Ti) .* num - floor(Ts./Ti) .* shift;
Q0 = [q0,Q(1:end-1)];
B_new = B + Q0 - Q;
