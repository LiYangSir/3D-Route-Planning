%% 初始化可行路径种群
%输入：
% NP      种群大小
% CityNum 个体染色体长度（这里为城市的个数）
% S       起点编号
% T       终点编号
%输出：
% X       初始种群
function X=InitPop(NP,D)
CityNum=size(D,1);

for i=1:NP
    route=round(rand(1,CityNum));
    route([1 end])=[1 1];      % 起点与终点为必经点,置1
    X(i,:)=route;
end