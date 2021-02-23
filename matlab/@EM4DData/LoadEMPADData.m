function [obj] = LoadEMPADData(obj, dataName, dataSize, varagin)
% 
%
if length(dataSize) ~= 2
   error('Wrong datasize in LoadEMPADData.') 
end
% Init Memory
try
    obj.data = zeros(dataSize(1)*dataSize(2), 128, 128);
catch
    error('Not enough memory in LoadEMPADData.') 
end
%
row = 128;
col = 128;
fin = fopen(dataName, 'r');
for ii = 1:(dataSize(1)*dataSize(2))
    if ii ~= 1
        tempSkipData = fread(fin, 256, 'single=>single', 'ieee-le'); 
    end
    I = fread(fin, row*col, 'single=>single', 'ieee-le'); 
    dp = reshape(I, row, col);
    dp = rot90(dp, 1);
    obj.data(ii, :, :) = dp;
end
fclose(fin);
end

