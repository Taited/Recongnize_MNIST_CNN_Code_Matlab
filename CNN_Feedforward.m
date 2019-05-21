function Y=CNN_Feedforward(x,W1,W2,W3)
%¾í»ýÂË²¨
v1=zeros(14,14,20);
for i=1:20
    w=rot90(W1(:,:,i),2);
    v1(:,:,i)=conv2(x,w,'valid');
end
%ReLu
y1=max(0,v1);
%³Ø»¯
y21=( y1(1:2:end,1:2:end,:)+...
    y1(2:2:end,1:2:end,:)+...
    y1(1:2:end,2:2:end,:)+...
    y1(2:2:end,2:2:end,:))/4;
%Full connect
y2=reshape(y21,[],1);
v2=W2*y2;
y3=max(0,v2);
V=W3*y3;
Y=softmax(V);%Êä³ö
end
