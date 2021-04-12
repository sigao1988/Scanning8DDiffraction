%% Load data & Parameters
mydata = Ptycho4D();
mydata.parameters.dataPath = 'C:\Users\gs\Desktop\a\';
mydata.parameters.savePath = mydata.parameters.dataPath;
mydata.parameters.dataSaveName = 'MyEM4DData';
mydata.parameters.dataSaveMethod = 'H5';
mydata.parameters.initDataMethod = 'AlltoMemory';
%
switch mydata.parameters.initDataMethod
    case 'AlltoMemory'
        mydata.LoadData();
end

% Init Probe
mydata.parameters.initProbeMethod = 'CEOS';
mydata.parameters.probeSaveName = 'ProbeGuess';
mydata.parameters.probeSaveMethod = 'H5';
% --fill in if not loaded--
% mydata.parameters.voltage
% mydata.parameters.maskRadius
% mydata.parameters.dx
% mydata.parameters.probeSize
% mydata.parameters.coeffi
%
mydata.InitProbe();

% Init Object
mydata.parameters.initObjectMethod = 'Ones';
mydata.parameters.objectSaveMethod = 'H5';
mydata.parameters.objectSaveName = 'ObjectGuess';
mydata.parameters.objectFrames = 1;
mydata.parameters.objectGaps = [0];
mydata.parameters.objectSize = [512,512];
%
mydata.InitObject();

% Init Trans
mydata.parameters.initTransMethod = 'RasterScan';
mydata.parameters.transSaveName = 'TransGuess';
% --fill in if not loaded--
% mydata.parameters.transFrames
% mydata.parameters.transStep
% mydata.parameters.trans
%
% -- or mydata.InitTrans();
% mydata.ShiftTrans('Center');

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

%% Main
clc
tic
mydata.run();
toc

