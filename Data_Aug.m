function x=Data_Aug(x)
flag=rand();
theSize=size(x,1);
if flag>0.5
    x=imrotate(x,25,'bilinear');
else
    x=imrotate(x,-25,'bilinear');
end

margin=(size(x,1)-theSize)/2;
margin=floor(margin);
x=x(margin:margin+theSize-1,margin:margin+theSize-1);

flag=rand();
if flag<0.6
    SE=strel('square',2);
    if flag<0.3
        x=imdilate(x,SE);%Í¼Æ¬ÅòÕÍ
    else
        x=imerode(x,SE);%Í¼Æ¬¸¯Ê´
    end
end
            
% subplot(2,3,1)
% imshow(x)
% SE=strel('square',2);
% qwq=imdilate(x,SE);
% subplot(2,3,2)
% imshow(qwq)
% tut=imerode(x,SE);
% subplot(2,3,3)
% imshow(tut)
end