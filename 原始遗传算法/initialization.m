%% ��Ⱥ��ʼ������
% ���룺pop_size����Ⱥ��ģ  I��������  M����������
%       Mj�����ޱ�  Ti���ӹ�ʱ��
% �����pop����ʼ��Ⱥ
%% -----------------------------------------------------------------
function pop = initialization(pop_size,I,M,Mj)
pop = zeros(pop_size,M);
i = 1;
while i <= pop_size
    for m = 1:M
        Sm = Mj{m};
        ind = randperm(length(Sm),1);
        pop(i,m) = Sm(ind);
    end
    % �������򲻼ӹ���Ⱦɫ�壬��������Ⱦɫ��
    for j = 1:I
        if isempty(find(pop(i,:)==j,1))
            i = i - 1;
            break;
        end
    end
    i = i + 1;
end