function [obj] = EMPADTrans(obj, dataSize, step)
%

%
count=0;
for ii=1:dataSize(1)
    for jj=1:dataSize(2)
        count=count+1;
        obj.trans.x(count,1) = ii * step(1) ;
        obj.trans.y(count,1) = jj * step(2) ;
    end
end
end

