%% Creat STEMSIM and parameters
mydata = STEMSIM();
% method 1 : 
% mydata.FillinParameters();
% method 2 : 
% mydata.Loadparameters();
% method 3 : 
mydata.parameters.voltage = 300;
mydata.parameters.probeSize = [256,256];
mydata.parameters.dx = [0.1,0.1];
mydata.parameters.maskRadius = [0,22];
mydata.parameters.coeffi = [30,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;];
%-----------------------%
mydata.parameters.transFrames = [3,3];
mydata.parameters.transStep = [5,5];
mydata.parameters.dataBatchSize = 100;
%-----------------------%
mydata.parameters.objectSize = [512,512];
mydata.parameters.objectFrames = 2;
mydata.parameters.objectGaps = [5,0];
%-----------------------%
mydata.parameters.initProbeMethod = 'CEOS';
mydata.parameters.initObjectMethod = 'Ones';
mydata.parameters.initTransMethod = 'RasterScan';
mydata.parameters.savePath = 'C:\Users\gs\Desktop\a\';
mydata.parameters.objectSaveName = 'TrueObject';
mydata.parameters.probeSaveName = 'TrueProbe';
mydata.parameters.transSaveName = 'TrueTrans';
mydata.parameters.parameterSaveName = 'STEMSIM';
mydata.parameters.dataSaveName = 'MyEM4DData';
mydata.parameters.probeSaveMethod = 'H5';
mydata.parameters.objectSaveMethod = 'H5';
mydata.parameters.dataSaveMethod = 'H5';

% Init probe
mydata.InitProbe();

% Init object
mydata.InitObject();
load('.\source\cameraman.mat')
load('.\source\jetplane.mat')
load('.\source\house.mat')
load('.\source\lena.mat')
mydata.object.SetAmpImage(cameraman,[0.95,1],1);
mydata.object.SetPhsImage(lena,[0,0.1],1);
mydata.object.SetAmpImage(house,[0.95,1],2);
mydata.object.SetPhsImage(jetplane,[0,0.1],2);

% Init trans
mydata.InitTrans();
mydata.ShiftTrans('Center');

%% Main
mydata.ScanningDP();

