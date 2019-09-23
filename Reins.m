 %% 重插入子代的新种群
 %输入：
 % X  父代的种群
 % XSel  子代种群
 % fitness   父代适应度
 % 输出
 % X  组合父代与子代后得到的新种群
function X=Reins(X,XSel,fit)
NP=size(X,1);
NSel=size(XSel,1);
[~,index]=sort(fit,'descend');
X=[X(index(1:NP-NSel),:);XSel];