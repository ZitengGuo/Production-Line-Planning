%% ��Ⱥ��ʼ������
% ���룺pop_size����Ⱥ��ģ  I��������  M����������  w1,w2: 2�ֱ���  
%       Mj�����ޱ�  Ti���ӹ�ʱ��
% �����pop����ʼ��Ⱥ
%% -----------------------------------------------------------------
function pop = initialization(pop_size,I,M,w1,w2,Mj,Ti)
pop = zeros(pop_size,M);
%% ���ھֲ��豸���ܾ���ĳ�ʼ������
i = 1;
while i <= w1*pop_size
    for m = 1:M
        Sm = Mj{m};   % �����ܼӹ��Ĺ���
        St = Ti(Sm);  % ��Ӧ����ӹ�ʱ��
        prob = St / sum(St);
        prob_cum = cumsum(prob);
        ind = find(prob_cum>rand,1);
        pop(i,m) = Sm(ind);
    end
    i = judge(pop(i,:),I,i);
end
%% ����ȫ�ֹ�����ܾ���ĳ�ʼ������
while i <= w2*pop_size
    L = 0.001*ones(1,I);  % ���ɳ�ʼ��
    M_rand = randperm(M); % �豸���ѡ������
    for m = 1:M
        Sm = Mj{M_rand(m)};
        St = Ti(Sm);
        prob = sum(L(Sm)) ./ L(Sm);
        prob = prob/sum(prob);
        prob_cum = cumsum(prob);
        ind = find(prob_cum>rand,1);
        pop(i,M_rand(m)) = Sm(ind);
        L(Sm(ind)) = L(Sm(ind)) + 1 / St(ind);
    end
    i = judge(pop(i,:),I,i);
end
%% ������ɵĳ�ʼ������
while i <= pop_size
    for m = 1:M
        Sm = Mj{m};
        ind = randperm(length(Sm),1);
        pop(i,m) = Sm(ind);
    end
    i = judge(pop(i,:),I,i);
end