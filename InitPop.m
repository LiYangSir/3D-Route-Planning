%% ��ʼ������·����Ⱥ
%���룺
% NP      ��Ⱥ��С
% CityNum ����Ⱦɫ�峤�ȣ�����Ϊ���еĸ�����
% S       �����
% T       �յ���
%�����
% X       ��ʼ��Ⱥ
function X=InitPop(NP,D)
CityNum=size(D,1);

for i=1:NP
    route=round(rand(1,CityNum));
    route([1 end])=[1 1];      % ������յ�Ϊ�ؾ���,��1
    X(i,:)=route;
end