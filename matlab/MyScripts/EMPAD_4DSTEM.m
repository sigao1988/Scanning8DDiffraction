%% Load EMPAD Data
mydata =  EM4DData();
mydata.dataSize = [128,128,128,128];
mydata.LoadEMPADData('C:\Users\gs\Desktop\10\scan_x128_y128.raw',mydata.dataSize(1:2));

%% Do 4DSTEM


%% Do Ptycho
mydata.EMPADTrans(mydata.dataSize(1:2), [0.19/0.3286, 0.19/0.3286]);
% use TempNewStarter
