function F = Fitness(X,D,delta,alpha1,alpha2,beta1,beta2,theta,tag)
route = find(X~=0);  % 去掉0的路径
dist = 0;
for j = 1:length(route)-1
    dist = dist + D(route(j),route(j+1));
end
big = sum(sum(D));
punish = 0;
errorH = 0;     % 水平误差
errorV = 0;     % 垂直误差
for j = 2 : length(route)-1
    dv = D(route(j-1),route(j));
    errorH = errorH + dv * delta;
    errorV = errorV + dv * delta;
    if errorV <= alpha1 && errorH <= alpha2 && errorV <= beta1 && errorH <= beta2
        % 校正
        if tag(route(j)) == 0
            % 水平校正
            errorH = 0;
        end
        if tag(route(j)) == 1
            % 垂直校正
            errorV = 0;
        end
    else
        punish = punish + 1;
    end
end
%% 最后到终点
errorH = errorH + D(route(end-1),route(end)) * delta;
errorV = errorV + D(route(end-1),route(end)) * delta;
if errorH <= theta && errorV <= theta
else
    punish = punish + 1;
    
end
F = dist + punish * big;

