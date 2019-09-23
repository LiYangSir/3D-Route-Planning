%% 进化逆转函数
%输入
% XSel 被选择的个体
% D     个城市的距离矩阵
% 输出
% XSel  进化逆转后的个体
function YSel=Reverse01(YSel,D,delta,alpha1,alpha2,beta1,beta2,theta,tag)
[NSel,CityNum]=size(YSel);
for i=1:NSel
    route=YSel(i,:);
    fx=Fitness(route,D,delta,alpha1,alpha2,beta1,beta2,theta,tag);
    r1=randi(CityNum-2)+1;      % 不包括首末节点
    r2=randi(CityNum-2)+1;
    while r2==r1
        r2=randi(CityNum-2)+1;
    end
    id1=min(r1,r2);
    id2=max(r1,r2);
    route(id1:id2)=~route(id1:id2);
    fnew=Fitness(route,D,delta,alpha1,alpha2,beta1,beta2,theta,tag);
    if fnew<fx
        YSel(i,:)=route;
    end
end
