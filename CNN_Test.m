function errors=CNN_test_Reduce(W1,W2,W3,X_Test,D_Test,margin)
X=zeros(28-2*margin,28-2*margin,size(X_Test,3));%0-1化的数据
for i=1:size(X_Test,3)
    X(:,:,i)=X_Test(margin+1:end-margin,margin+1:end-margin,i);
end
D=D_Test;
index=1;errors=zeros(3,20);
for i=1:size(D_Test,2)
    x=X(:,:,i);
    d=D(1:10,i);
    [~,d]=max(d);
    Y=CNN_Feedforward(x,W1,W2,W3);
    [~,my_index]=max(Y);
    if my_index~=d
        errors(1,index)=i;
        errors(2,index)=my_index;
        errors(3,index)=d;
        index=index+1;
    end
end
end