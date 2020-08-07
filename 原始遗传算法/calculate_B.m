%% ���㹤������Ʒ
% ���룺B����һ���ڹ�������Ʒ   I����������   
%       chrom������k����   chrom_o������(k-1)���Ÿ���
%       Tc������ƽ��ʱ��   Ts���л���ʱ   Ti������ӹ�ʱ�� 
%       q0��ÿ�������ڵ����׹������������
% �����B_new�����º�Ĺ�������Ʒ
%% -----------------------------------------------------------------
function B_new = calculate_B(B,I,chrom,chrom_o,Tc,Ts,Ti,q0)
ind = cell(1,I);  % ������ʹ�õĻ�������
num = zeros(1,I); % ������ʹ�õĻ�������
for i = 1:I
    ind{i} = find(chrom==i);
    num(i) = length(ind{i});
end
shift = zeros(1,I); % ����������л�����֮��
if ~isempty(chrom_o)
    for i = 1:I
       ii = ind{i};
       shift(i) = length(find(chrom_o(ii)~=i));
    end
end
Q = floor(Tc./Ti) .* num - floor(Ts./Ti) .* shift;
Q0 = [q0,Q(1:end-1)];
B_new = B + Q0 - Q;
