clc
clear
close all
data = xlsread('����.xlsx','B4:E614');
Ps = [0.00 	50000.00 	5000.00 ];
Pe = [100000.00 	59652.34 	5022.00];
XYZ = data(:,1:3);
tag = data(:,4);
plot3(XYZ(tag==0,1),XYZ(tag==0,2),XYZ(tag==0,3),'b.')
hold on
plot3(XYZ(tag==1,1),XYZ(tag==1,2),XYZ(tag==1,3),'r.')
plot3(Ps(1),Ps(2),Ps(3),'go','MarkerFacecolor','g')
plot3(Pe(1),Pe(2),Pe(3),'gs','MarkerFacecolor','g')
% legend('ˮƽУ����','��ֱУ����','���A','�յ�B')
%%
[x,id] = sort(XYZ(:,1));
xyz = XYZ(id,:);
tag = tag(id);
alpha1 = 25;
alpha2 = 25;
beta1 = 20;
beta2 = 25;
theta = 30;
delta = 0.001;
m = min([alpha1,alpha2,beta1,beta2]);
ds = m / delta;   % ����У��������ǰ������
%%
NP = 100;         % ��Ⱥ��С
maxgen = 200;     % ����������
Pc = 0.8;         % �������
Pm = 0.2;        % �������
Gap = 0.9;        % ����(Generation gap)
%%
xyz = [Ps; xyz; Pe];
tag = [0; tag; 0];
T =size(xyz,1);
D = zeros(T);
for i = 1 : T
    for j = 1 : T
        D(i,j) = sqrt(sum((xyz(i,:) - xyz(j,:)).^2));
    end
end
 big  = sum(sum(D));
i = 1;
while i <= NP
    i
    x = 1;
    last = 1;
    errorH = 0;     % ˮƽ���
    errorV = 0;     % ��ֱ���
    flag = 1;
    while 1
        d2end = sqrt(sum((xyz(last,:) - Pe).^2));   % ������һ��У���㵽�յ�ľ���<ds
        errorHd = errorH + d2end * delta;
        errorVd = errorV + d2end * delta;
        if errorHd <= theta && errorVd <= theta
            x = [x T];
            break
        end
        d = D(:,last);
        d(x) = big;               % ȥ���������ĵ�
        ida = (d <= ds/2);        % �������ǰ�����������
        idb = (xyz(:,1) > xyz(last,1));
        idc = ida & idb;
        can = find(idc == 1);      % ��ѡ��
        if isempty(can)
            break
        end
        % �ڽ���Ѱ������������У����
        for ii = 1 : length(can)
            v = can(randi(length(can)));
            dv = d(v);
            errorHi = errorH + dv * delta;
            errorVi = errorV + dv * delta;
            if errorV <= alpha1 && errorH <= alpha2 && errorV <= beta1 && errorH <= beta2
                x = [x v];
                last  = v;
                errorH = errorHi;
                errorV = errorVi;
                break
            end
        end
        if ii == length(can)
           break 
        end
 
        % У��
        if tag(v) == 0
            % ˮƽУ��
            if errorV <= alpha1 && errorH <= alpha2
                errorH = 0;
            end
        end
        if tag(v) == 1
            % ��ֱУ��
            if errorV <= beta1 && errorH <= beta2
                errorV = 0;
            end
        end
    end
%     for ii = 1 : length(x)-1
%         x(ii),x(ii+1)
%         D(x(ii),x(ii+1))
%     end
    if x(end) == T
        y = zeros(1,T);
        y(x) = 1;
        Y(i,:) = y;
        i = i + 1;
    end
end

%% �Ŵ�����
gen=1;

for i=1:NP
    Fy(i)=Fitness(Y(i,:),D,delta,alpha1,alpha2,beta1,beta2,theta,tag);      % ����·�߳���
end
fpbest=min(Fy);
while gen<maxgen
    gen
    % ��¼��������ֵ
    fpbest=min(Fy);
    FG(gen)=fpbest;       % �������·��
    % ������Ӧ��
    fit=1./(Fy+1);   % ������С·��תΪ���ֵfit
    % ѡ��
    YSel=Select(Y,fit,Gap);
    % �������
    YSel=Cross01(YSel,Pc);
    % ����
    YSel=Mutate01(YSel,Pm);
    % ��ת����
    
    YSel=Reverse01(YSel,D,delta,alpha1,alpha2,beta1,beta2,theta,tag);
    % �ز����Ӵ�������Ⱥ
    Y=Reins(Y,YSel,fit);
    % ����·�߳���
    for i=1:NP
        Fy(i)=Fitness(Y(i,:),D,delta,alpha1,alpha2,beta1,beta2,theta,tag);      % ����·�߳���
    end
    % ���µ�������
    gen=gen+1 ;
end
%% �������Ž��·��ͼ
[minLength,minInd]=min(Fy);
gbest=Y(minInd,:);
path=find(gbest~=0)
for i = 1 : length(path) - 1
    plot3(xyz(path(i:i+1),1),xyz(path(i:i+1),2),xyz(path(i:i+1),3),'k-')
end
axis equal
%% ������Ž��·�ߺ��ܾ���
figure
plot(FG)
R = [1 0 0 0];
route = find(gbest~=0);  % ȥ��0��·��
dist = 0;
for j = 1:length(route)-1
    dist = dist + D(route(j),route(j+1));
end
big = sum(sum(D));
punish = 0;
errorH = 0;     % ˮƽ���
errorV = 0;     % ��ֱ���
for j = 2 : length(route)-1
    dv = D(route(j-1),route(j));
    errorH = errorH + dv * delta;
    errorV = errorV + dv * delta;
    R = [R;id(route(j)-1) errorV errorH tag(route(j))];
    if errorV <= alpha1 && errorH <= alpha2 && errorV <= beta1 && errorH <= beta2
        % У��
        if tag(route(j)) == 0
            % ˮƽУ��
            errorH = 0;
        end
        if tag(route(j)) == 1
            % ��ֱУ��
            errorV = 0;
        end
    else
        punish = punish + 1;
    end
end
%% ����յ�
errorH = errorH + D(route(end-1),route(end)) * delta;
errorV = errorV + D(route(end-1),route(end)) * delta;
R = [R; T errorV errorH 0];
if errorH <= theta && errorV <= theta
else
    punish = punish + 1;
    
end
F = dist + punish * big + length(route) * min(min(D));
fprintf('����·�����룺%f\n',dist)
fprintf('������У������ĿΪ %d\n',length(route)-2)
disp(R)