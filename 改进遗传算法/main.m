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
    [2,3],[2,4],[1,3,4],[2,3,4],[2,3,4],[1,2,3,4]};   % ���ޱ�
w1 = 0.3;                   % ��ʼ����Ⱥ����1
w2 = 0.9;                   % ��ʼ����Ⱥ����2
Pc = 0.8;                   % �������
Pm = 0.2;                   % �������
s = 10;                     % ��Ӣ����
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
    pop = initialization(pop_size,I,M,w1,w2,Mj,Ti);
    %% �����ʼ��Ⱥ����Ӧ��ֵ
    [Z,B,pop] = fitness(pop,pop_best{k},B_best{k},I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta);
    for g = 1:Iter
        fprintf('��ǰ������|����������'),disp([num2str(k) '|' num2str(g)])
        %% ѡ�����
        [parent1,Z1,B1,parent2] = selection(pop,Z,B,s,pop_size,M);
        %% �������
        parent2 = crossover(parent2,Pc,Mj,I,M);
        %% �������
        parent2 = mutation(parent2,Pm,Mj,M);
        %% ������Ⱥ��Ӧ��
        [Z2,B2,parent2] = fitness(parent2,pop_best{k},B_best{k},I,Tc,Ts,Ti,q0,Mj,Lm,alpha,beta);
        %% �ϲ���Ⱥ
        pop = [parent1;parent2];
        Z = [Z1,Z2];
        B = [B1;B2];
        %% ��ȡ����������Ӧ��ֵ
        lbest(g) = min(Z);
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