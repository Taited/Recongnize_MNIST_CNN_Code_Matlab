function [dW1,dW2,dW3]=CNN_BP_Mt(x,d,W1,W2,W3,m1,m2,m3)

alpha=0.01;%学习速率
beta=0.01;%动量项系数

%前馈过程
%卷积滤波
v1=zeros(14,14,20);
for i=1:20
    w=rot90(W1(:,:,i),2);
    v1(:,:,i)=conv2(x,w,'valid');
end
%ReLu
y1=max(0,v1);

%池化
y21=( y1(1:2:end,1:2:end,:)+...
    y1(2:2:end,1:2:end,:)+...
    y1(1:2:end,2:2:end,:)+...
    y1(2:2:end,2:2:end,:))/4;
%Full connect
y2=reshape(y21,[],1);
v2=W2*y2;
y3=max(0,v2);
V=W3*y3;
Y=softmax(V);

%误差反向传播
e=d-Y;
delta=e;

dW3=0.5*alpha*delta*y3'+beta*m3;
e3=W3'*delta;

delta3=(v2>0).*e3;
dW2=0.5*alpha*delta3*y2'+beta*m2;
e2=W2'*delta3;

E2=reshape(e2,size(y21));

E1 = zeros(size(y1)); E2_4= E2/4;
E1(1:2:end,1:2:end,:) = E2_4;
E1(1:2:end,2:2:end,:) = E2_4;
E1(2:2:end,1:2:end,:) = E2_4;
E1(2:2:end,2:2:end,:) = E2_4;

delta1=(v1>0).*E1;

dW1=zeros(size(W1));
for i=1:20
    w=rot90(delta1(:,:,i),2);
    dW1(:,:,i)=alpha*conv2(x,w,'valid')+beta*m1(:,:,i);
end

end