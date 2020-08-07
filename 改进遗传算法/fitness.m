%% 适应度函数
% 输入：pop：种群  chrom_o：上周期最优个体  W：上周期剩余在制品数量  I：工序总数
%       Tc：单次平衡周期时长  Ts：设备切换时间  Ti：工序加工时间
%       q0：每个周期内到达首工序的物料总量  M：机器数 Lm：最大负荷
%       alpha：目标1权重  beta：目标2权重
% 输出：个体适应度
%% -----------------------------------------------------------------
function [Z,B,pop] = fitness(pop,chrom_o,W,I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta)
pop_size = size(pop,1);  % 种群规模
Z = zeros(1,pop_size);   % 适应度值
B = zeros(pop_size,I);   % 当前周期在制品数量
for i = 1:pop_size
    B(i,:) = calculate_B(W,I,pop(i,:),chrom_o,Tc,Ts,Ti,q0);
    [pop(i,:),B(i,:)] = repair(B(i,:),W,I,pop(i,:),chrom_o,Tc,Ts,Ti,q0,Mj,Lm);
    % 目标1：工序负荷方差
    Z1 = sum((B(i,:).*Ti - B(i,:)*Ti'/I).^2) / I;
    if isempty(chrom_o)
        Z(i) = Z1;
    else
        % 目标2：机器切换次数
        Z2 = sum(pop(i,:) ~= chrom_o);
        Z(i) = alpha * Z1 + beta * Z2;
    end
end
