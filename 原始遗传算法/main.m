%% ������
%% -----------------------------------------------------------------
clear,clc
tic
%% ������ʼ��
I = 4;                      % ������
M = 13;                     % ������
K = 7;                      % ������
Tc = 24*60;                 % ÿ������ʱ����ͳһ��λΪmin��
Ts = 20;                    % �л���ʱ
q0 = 5100;                  % ÿ�����ڵ����׹������������
alpha = 1;                  % Ŀ�꺯��Ȩ��1
beta = 10^4;                % Ŀ�꺯��Ȩ��2
Ti = [50,58,53,55]/60;      % ����ӹ�ʱ��
W = [2179,1425,3692,2047];  % ��ʼ����Ʒ����
Lm = 30*60;                 % ������󸺺���
Mj = {[2,4],[1,3],[1,4],[1,2,3],[1,3],[3,4],[1,2,4],...
    [2,3],[2,4],[1,3,4],[2,3,4],[2,3,4],[1,2,3,4]};     % ���ޱ�
Pc = 0.8;                   % �������
Pm = 0.2;                   % �������
Iter = 100;                 % ��������
pop_size = 100;              % ��Ⱥ����
lbest = zeros(1,Iter);      % ÿ������ÿ�ε�����������Ӧ��ֵ
gbest = zeros(1,K);         % ÿ������������Ӧ��ֵ
pop_best = cell(1,K+1);     % ÿ���������ŵĸ��壨������2��ʼ��
B_best = cell(1,K+1);       % ��Ӧ��������ʣ�������Ʒ������������2��ʼ��
B_best{1} = W;              % ��ʼ����Ʒ����
%% ��ѭ��
for k = 1:K
    %% ��ʼ����Ⱥ
    pop = initialization(pop_size,I,M,Mj);
    %% �����ʼ��Ⱥ����Ӧ��ֵ
    [Z,B,pop] = fitness(pop,pop_best{k},B_best{k},I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta);
    [gb,ind] = min(Z);
    pop_gb = pop(ind,:);
    B_gb = B(ind,:);
    for g = 1:Iter
        fprintf('��ǰ������|����������'),disp([num2str(k) '|' num2str(g)])
        %% ѡ�����
        pop = selection(pop,Z,pop_size);
        %% �������
        pop = crossover(pop,Pc,Mj,M);
        %% �������
        pop = mutation(pop,Pm,Mj,M);
        %% ������Ⱥ��Ӧ��
        [Z,B,pop] = fitness(pop,pop_best{k},B_best{k},I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta);
        %% ��ȡ����������Ӧ��ֵ
        [lbest(g),ind] = min(Z);
        if lbest(g) <= gb
            gb = lbest(g);
            pop_gb = pop(ind,:);
            B_gb = B(ind,:);
        else
            lbest(g) = gb;
            pop(1,:) = pop_gb;
            B(1,:) = B_gb;
        end
    end
    %% ����ͼ��
    subplot(3,3,k)
    plot(1:Iter,lbest)
    %% ��¼�����������Ž��
    [gbest(k),ind] = min(Z);
    pop_best{k+1} = pop(ind,:);
    B_best{k+1} = B(ind,:);
end
Z_total = sum(gbest);   % ��Ӧ���ܺ�
toc