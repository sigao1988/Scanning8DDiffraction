%% TempNewStarter()
p.switch.init_probe_mode=5;%1=df 2=aptured df 3=randon_phase 4=apetrure with zeros 5=load dp_ref 6=back_fronhofer 7=QSTEM format
p.switch.probe_update_after=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
p.switch.updateexitwaveafter=0; % 0==ePIE others==PIE   
p.switch.updatefunction_object=1;%0=notupdata 1=ePIE 2=LeiTian's 3=Thibault's 4=PIE
p.switch.updatefunction_probe=1;%0=notupdata 1=ePIE 2=LeiTian's 3=Thibault's 4=PIE

%------ END switch parameters ------%

%------ Basic parameters ------%
p.beam_voltage = 300; % keV
p.semiangle = 22;%mrad
p.slicesnum = 1;
p.sliceloc = [0:500:1000];
p.savepath = ['C:\Users\gs\Desktop\a\'];
p.iter = 1;
%------ END basic parameters ------%

%------ File parameters ------%4
p.filename.p='parameters';
p.filename.dp='dp_';
p.filename.image_ref='dp_ref.mat';
p.filename.obj_guess='obj_guess';
p.filename.probe_guess='probe_guess';
p.filename.dp_positions='trans_guess_out.mat';


p.coeffi(1,:) = [15 0];%  nm      C10     df
p.coeffi(2,:) = [0 0];%    nm      C12     A1
p.coeffi(3,:) =[0 0];%     nm      C21     B2
p.coeffi(4,:) = [0 0];%    nm      C23     A2
p.coeffi(5,:) =[0 0];%um      C3      C3
p.coeffi(6,:) = [0 0];%    um      C32     S3
p.coeffi(7,:) = [0 0];%    um      C34     A3
p.coeffi(8,:) = [0 0];%    um      C41     A4
p.coeffi(9,:) = [0 0];%  T  um      C43     B4
p.coeffi(10,:) = [0 0];%   um      C45     D4
p.coeffi(11,:) = [0 0];%   mm      C5      C5
p.coeffi(12,:) = [0 0];%   mm      C56     A5

p.dp.num = 900;
p.dp.size = [256, 256];
p.dp.dxy = [0.1,0.1]; % A

p.recon.alpha_obj= 1;
p.recon.alpha_probe= 1;
p.recon.avoid_zeros= 1e-6;
p.recon.PDA_amplify=[100 100]; % position determing algorithm from Fucai Zhang ; 0 =uodo
p.recon.PDA_slice=p.slicesnum;%p.slicesnum; %p.slicesnum;%To which slice we do PDA
p.recon.PDA_adjust_amplify=1;%1=yes 0=no
p.recon.PDA_afteriteration=999;
p.recon.PDA_overlap_afteriteration=p.recon.PDA_afteriteration;


if ~exist(p.savepath,'dir')
    mkdir(p.savepath)
end
p.dp.x = h5readatt('C:\Users\gs\Desktop\a\MyEM4DData.h5','/tags/','transI');
p.dp.y = h5readatt('C:\Users\gs\Desktop\a\MyEM4DData.h5','/tags/','transJ');
p.exec.x= p.dp.x;%-floor(min(p.dp.x))+ceil(p.recon.dxy_adjustment(1));
p.exec.y= p.dp.y;%-floor(min(p.dp.y))+ceil(p.recon.dxy_adjustment(2));

p.exec.PDA_amplify=p.recon.PDA_amplify;
p.exec.lamda=1.23984244/sqrt(p.beam_voltage*(2*510.99906+p.beam_voltage))*10;% A
p.exec.df=1/p.dp.dxy(1)/p.dp.size(1);%A-1
p.exec.dk=p.exec.lamda*p.exec.df;%rad
%func
p.func.myfft=@(x) ifftshift(fft2(fftshift(x)))/sqrt(numel(x(:)));
p.func.myifft=@(x) ifftshift(ifft2(fftshift(x)))*sqrt(numel(x(:)));
save([p.savepath 'parameters_initial.mat'],'p');

% initialize
datatemp = h5read('C:\Users\gs\Desktop\a\MyEM4DData.h5','/data/'); 
for count_dp = 1:p.dp.num
    dps{count_dp}=sqrt(abs(datatemp(:,:,count_dp)));
end
dp_ref = dps{1};

amp = h5read('C:\Users\gs\Desktop\a\TrueProbe.h5','/amp/');
phs = h5read('C:\Users\gs\Desktop\a\TrueProbe.h5','/phs/');
probe_guess=amp.*exp(1j.*phs);

amp = h5read('C:\Users\gs\Desktop\a\TrueObject.h5','/dataSlice1/amp/');
phs = h5read('C:\Users\gs\Desktop\a\TrueObject.h5','/dataSlice1/phs/');
obj_guess{1} = amp.*exp(1j.*phs);

%% main
[ p , probe_guess , obj_guess ] = TPIE_Engine( p , probe_guess , obj_guess , dp_ref , dps );

save([p.savepath p.filename.obj_guess],'obj_guess','-v7.3');
save([p.savepath p.filename.probe_guess],'probe_guess','-v7.3');
save([p.savepath 'parameters_final'],'p','-v7.3');
trans_guess_out.x=p.exec.x;
trans_guess_out.y=p.exec.y;
save([p.savepath 'trans_guess_out_final'],'trans_guess_out','-v7.3');

