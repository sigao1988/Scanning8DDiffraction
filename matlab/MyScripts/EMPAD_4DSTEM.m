%% Standalone Load EMPAD Data Method
mydata = EM4DData();
mydata.dataSize = [128,128,128,128];
mydata.LoadEMPADData('C:\Users\gs\Desktop\10\scan_x128_y128.raw',mydata.dataSize(1:2));
mydata.referenceImage = mydata.data(:,:,1);
mydata.EMPADTrans(mydata.dataSize(1:2), [0.19/0.3286, 0.19/0.3286]);
 

%% Parameters
mydata = Ptycho4D();
mydata.parameters.dataPath = '/home/gs/disk_program/structure_beam/new/20210319_07_C2_x4_Cl285_5.1M_0.2/';
mydata.parameters.savePath = mydata.parameters.dataPath;
mydata.parameters.dataSaveName = 'MyEM4DData';
mydata.parameters.dataSaveMethod = 'H5';
mydata.parameters.initDataMethod = 'AlltoMemory';
% Init Probe
mydata.parameters.initProbeMethod = 'CEOS';
mydata.parameters.probeSaveName = 'ProbeGuess';
mydata.parameters.probeSaveMethod = 'H5';
mydata.parameters.voltage = 300;
mydata.parameters.maskRadius = [0,22];
mydata.parameters.dx = [0.16, 0.16];
mydata.parameters.probeSize = [128,128];
mydata.parameters.coeffi = [0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0];
% Init Object
mydata.parameters.initObjectMethod = 'Ones';
mydata.parameters.objectSaveMethod = 'H5';
mydata.parameters.objectSaveName = 'ObjectGuess';
mydata.parameters.objectFrames = 1;
mydata.parameters.objectGaps = [0];
mydata.parameters.objectSize = [1024,1024];
% Init Trans
mydata.parameters.initTransMethod = 'RasterScan';
mydata.parameters.transSaveName = 'TransGuess';
mydata.parameters.transFrames = [256, 256];
mydata.parameters.transStep = [0.28, 0.28];
% Reconstruct Parameters
mydata.parameters.parameterSaveName = 'ParametersPtycho4D';
mydata.parameters.alphaObject = 1;
mydata.parameters.alphaProbe = 1;
mydata.parameters.iterNum = 1;
mydata.parameters.dataBatchSize = 100;
mydata.parameters.info = 'v0.1.0';
mydata.parameters.algorithm = 'TPIESimple';
mydata.parameters.probeUpdateMethod = 'ePIE';
mydata.parameters.objectUpdateMethod = 'ePIE';
mydata.parameters.dataUpdateMethod = 'simple';

%% Load data & 4DSTEM
% mydata = Ptycho4D();
mydata.EM4DData.dataSize = [128,128,256,256];
mydata.EM4DData.LoadEMPADData('/home/gs/disk_program/NJUTEM_2020/20210319_Au/07_C2_50_CL285_5.1m_0.2/scan_x256_y256.raw',mydata.EM4DData.dataSize(3:4));
mydata.EM4DData.referenceImage = mydata.EM4DData.data(:,:,1);
% save
mydata.EM4DData.fileName = mydata.parameters.dataSaveName;
mydata.EM4DData.filePath = mydata.parameters.dataPath;
mydata.EM4DData.dataSaveMethod = 'H5';
mydata.EM4DData.Save();

%% 4D-STEM
mask = CreatMask('Round', [128,128], [1, 1], [40, 64]);
ADF = mydata.EM4DData.IntergratedWithMask(mask);
Save2DImage(ADF, 'TIFF', '/home/gs/disk_program/structure_beam/new/20210319_07_C2_x4_Cl285_5.1M_0.2/', 'ADF');

%% Ptycho
mydata.InitProbe();
mydata.InitObject();
mydata.InitTrans();
mydata.ShiftTrans('Center');
%
clc
tic
mydata.run();
toc
