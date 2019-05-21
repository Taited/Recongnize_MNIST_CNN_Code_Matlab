close all;
clear;
load 'C:\Users\HP\Desktop\MNISTData.mat';

margin=3;%裁剪图片最外围三圈
X=zeros(28-2*margin,28-2*margin,60000);%X用于存储剪裁过后的图片矩阵
for i=1:size(X_Train,3)
    X(:,:,i)=X_Train(margin+1:end-margin,margin+1:end-margin,i);
end

W1=randn(9,9,20);%初始化20个卷积核
W2=(2*rand(100,980)-1);
W3=(2*rand(10,100)-1);
dW1=zeros(size(W1));%作为动量项的初始0动量
dW2=zeros(size(W2));
dW3=zeros(size(W3));

lambda=2e-6;%正则化系数0.000002

tic%开始计时
for epoch=1:5
    for each=1:6e4
        i=round(unifrnd(1,60000));%i为1~6w之间一个均匀分布的随机整数
        x=X(:,:,i);
        d=D_Train(:,i);
%         flag=rand();
%         if flag>0.9
%             x=Data_Aug(x);
%         end
        [dW1,dW2,dW3]=CNN_BP_Mt(x,d,W1,W2,W3,dW1,dW2,dW3);
        %更新权值
        W1=W1+dW1-lambda*W1;
        W2=W2+dW2-lambda*W2;
        W3=W3+dW3-lambda*W3;
    end
end
toc%输出训练时间

%显示正确率
errors=CNN_Test(W1,W2,W3,X_Test,D_Test,margin);
rate=1-size(errors,2)/size(X_Test,3);
disp(['正确率为：',num2str(rate)]);

%显示25张识别错误的图片
for i=1:25
    x=X_Test(:,:,errors(1,i));
    subplot(5,5,i);
    imshow(x);
    text(26,3,num2str(errors(2,i)),'fontsize',20,'horiz','center','color','r');%识别出的错误标签
    text(26,24,num2str(errors(3,i)),'fontsize',20,'horiz','center','color','r');%正确的标签
end
