%% ��Ӧ�Ⱥ���
% ���룺pop����Ⱥ  chrom_o�����������Ÿ���  W��������ʣ������Ʒ����  I����������
%       Tc������ƽ������ʱ��  Ts���豸�л�ʱ��  Ti������ӹ�ʱ��
%       q0��ÿ�������ڵ����׹������������  M�������� Lm����󸺺�
%       alpha��Ŀ��1Ȩ��  beta��Ŀ��2Ȩ��
% �����������Ӧ��
%% -----------------------------------------------------------------
function [Z,B,pop] = fitness(pop,chrom_o,W,I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta)
pop_size = size(pop,1);  % ��Ⱥ��ģ
Z = zeros(1,pop_size);   % ��Ӧ��ֵ
B = zeros(pop_size,I);   % ��ǰ��������Ʒ����
for i = 1:pop_size
    B(i,:) = calculate_B(W,I,pop(i,:),chrom_o,Tc,Ts,Ti,q0);
    [pop(i,:),B(i,:)] = repair(B(i,:),W,I,pop(i,:),chrom_o,Tc,Ts,Ti,q0,Mj,Lm);
    % Ŀ��1�����򸺺ɷ���
    Z1 = sum((B(i,:).*Ti - B(i,:)*Ti'/I).^2) / I;
    if isempty(chrom_o)
        Z(i) = Z1;
    else
        % Ŀ��2�������л�����
        Z2 = sum(pop(i,:) ~= chrom_o);
        Z(i) = alpha * Z1 + beta * Z2;
    end
end
