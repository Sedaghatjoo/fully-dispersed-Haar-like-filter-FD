clc;
clear;
close all;
s_pic=64; % size of each image in data

load Pics % load Face data matrix
dataF = Pics;
load Clutter2 % load Clutter data matrix
dataC = Clutter2;

%% divide Face data to train and test
ind = randperm(size(dataF,1));
data = dataF(ind,:);
div = 0.7;
Ntrain = round(div*size(dataF,1));
Ntest = size(dataF,1)-Ntrain;
traindata = dataF(1:Ntrain,:);
testdata = dataF(Ntrain+1:end,:);


%% divide Clutter data to train and test
NCtrain = round(div*size(dataC,1));
cluttertrain = dataC(1:NCtrain,:);
cluttertest = dataC(NCtrain+1:end,:);
NCtest = size(dataC,1)-NCtrain;

%% Create Filter
% mean of Face data
Me_Face = sum(traindata)/Ntrain;
Me_Face = reshape(Me_Face,s_pic,s_pic);
% mean of Clutter data
Me_Clutter  = sum(cluttertrain)/NCtrain;
Me_Clutter = reshape(Me_Clutter,s_pic,s_pic);

%Best Location for Filter
Mf = Me_Face + (1/2-Me_Clutter);
num1 = 128; %pixels number of black
num2 = 128; %pixels number of white
k=0;
for j=1:s_pic
    for i=1:s_pic
        k=k+1;
        Indi(k)=i;
        Indj(k)=j;
    end
end
Mf=Mf(1:end);
[val,ind] = sort(Mf);

ind1=ind(1:num1);
I1=Indi(ind1);
J1=Indj(ind1);
%best Location for black pixels
lor1=I1;
loc1=J1;

ind2=ind(end-num2:end);
I2=Indi(ind2);
J2=Indj(ind2);
%best Location for white pixels
lor2=I2;
loc2=J2;
W=zeros(s_pic,s_pic);
B=zeros(s_pic,s_pic);
for k=1:num1
    B(I1(k),J1(k))=1;
end
for k=1:num2
    W(I2(k),J2(k))=1;
end
filter=1/2*ones(s_pic,s_pic);
filter(B>0)=0;
filter(W>0)=1;

%% extraction Features of Face train data
B1=B(1:end);
BB = repmat(B1,Ntrain,1);
A = traindata.*BB;
A0=sum(A>0,2);
MuB1=sum(A,2)./A0;

W1=W(1:end);
WW = repmat(W1,Ntrain,1);
AA = traindata.*WW;
AA0=sum(AA>0,2);
MuW1=sum(AA,2)./AA0;

m11=sum(MuB1)/length(MuB1);
m12=sum(MuW1)/length(MuW1);
M1 = [m11 m12];
Mu1=[MuB1 , MuW1];

%% extraction Features of Clutter train data
BBC = repmat(B1,NCtrain,1);
A_cl = cluttertrain.*BBC;
A0_cl = sum(A_cl>0,2);
MuB2 = sum(A_cl,2)./A0_cl;

WWC = repmat(W1,NCtrain,1);
AA_cl = cluttertrain.*WWC;
AA0_cl=sum(AA_cl>0,2);
MuW2=sum(AA_cl,2)./AA0_cl;

m21=sum(MuB2)/length(MuB2);
m22=sum(MuW2)/length(MuW2);
M2=[m21 m22];
Mu2=[MuB2 , MuW2];

%%  Optimal theta
Wh=[-1;1]; % Weight
tef = M1*Wh;
tec = M2*Wh;

Ff = Mu1*Wh;
Fc = Mu2*Wh;
for i=1:1000
    te(i) = tec+i/1000*(tef-tec);
    error_f = sum(Ff<te(i))/Ntrain;
    error_c=sum(Fc>te(i))/NCtrain;
    err(i)=norm([error_f error_c],'inf');
end
error = min(err);
te_op = te(err==min(err));
te_op = te_op(1);

%% Optimization filter
ii=1;
weightf = ones(1,Ntrain);
WR = zeros(1,Ntrain);
Neg=1;
weightc = ones(1,NCtrain);
WRc = zeros(1,NCtrain);
Pos=1;
while( ii<200)
    disp(['itteration= ', num2str(ii)]);
    
    weightf  = weightf  + WR;
    Me_Face  = weightf*traindata/sum(weightf);
    Me_Face = reshape(Me_Face,s_pic,s_pic);
    
    weightc  = weightc  + WRc;
    Me_Clutter  = weightc*cluttertrain/sum(weightc);
    Me_Clutter = reshape(Me_Clutter,s_pic,s_pic);
    In_Me_Clutter = (1/2-Me_Clutter);
    
    %% Best Location for Filter
    Mf = Me_Face + (1/2-Me_Clutter);
    Mf = histeq(Mf);
    Mf=Mf(1:end);
    [val,ind] = sort(Mf);
    
    ind1=ind(1:num1);
    I1=Indi(ind1);
    J1=Indj(ind1);
    %best Location for black pixels
    lor1=I1;
    loc1=J1;
    
    ind2=ind(end-num2:end);
    I2=Indi(ind2);
    J2=Indj(ind2);
    %best Location for white pixels
    lor2=I2;
    loc2=J2;
    
    W=zeros(s_pic,s_pic);
    B=zeros(s_pic,s_pic);
    for k=1:num1
        B(I1(k),J1(k))=1*-(Wh(1));
    end
    for k=1:num2
        W(I2(k),J2(k))=1*(Wh(2));
    end
    
    filter=1/2*ones(s_pic,s_pic);
    filter(B>0)=0;
    filter(W>0)=1;
    
    %% extraction Features of face train data
    
    B1=B(1:end);
    BB = repmat(B1,Ntrain,1);
    A = traindata.*BB;
    A0=sum(A>0,2);
    MuB1=sum(A,2)./A0;
    
    W1=W(1:end);
    WW = repmat(W1,Ntrain,1);
    AA = traindata.*WW;
    AA0=sum(AA>0,2);
    MuW1=sum(AA,2)./AA0;
    
    
    m11=sum(MuB1)/length(MuB1);
    m12=sum(MuW1)/length(MuW1);
    M1 = [m11 m12];
    Mu1=[MuB1 , MuW1];
    
    %% extraction Features of Clutter train data
    BBC = repmat(B1,NCtrain,1);
    A_cl = cluttertrain.*BBC;
    A0_cl = sum(A_cl>0,2);
    MuB2 = sum(A_cl,2)./A0_cl;
    
    WWC = repmat(W1,NCtrain,1);
    AA_cl = cluttertrain.*WWC;
    AA0_cl=sum(AA_cl>0,2);
    MuW2=sum(AA_cl,2)./AA0_cl;
    
    m21=sum(MuB2)/length(MuB2);
    m22=sum(MuW2)/length(MuW2);
    M2=[m21 m22];
    Mu2=[MuB2 , MuW2];
    
    %% Optimal theta
    
    tef = M1*Wh;
    tec = M2*Wh;
    
    Ff = Mu1*Wh;
    Fc = Mu2*Wh;
    for i=1:1000
        te(i) = tec+i/1000*(tef-tec);
        error_f = sum(Ff<te(i))/Ntrain;
        error_c=sum(Fc>te(i))/NCtrain;
        err(i)=norm([error_f error_c],'inf');
    end
    error(ii) = min(err);
    te_op = te(err==min(err));
    te_op = te_op(1);
    
    
    [af bf] =find(Ff<te_op);
    Neg=af;
    
    [ac bc] =find(Fc>te_op);
    Pos = ac;
    
    
    ep=20;
    Rf = (Ff-(te_op))';
    WR = 1./(1+exp(ep*Rf));
    
    Rc = (Fc-(te_op))';
    WRc= 1./(1+exp(-ep*Rc));
    
    
    %% Test of testdata
    
    %**********test data************
    BBt = repmat(B1,Ntest,1);
    At = testdata.*BBt;
    A0t=sum(At>0,2);
    MuB1t=sum(At,2)./A0t;
    
    WWt = repmat(W1,Ntest,1);
    AAt = testdata.*WWt;
    AA0t=sum(AAt>0,2);
    MuW1t=sum(AAt,2)./AA0t;
    
    Mu1t=[MuB1t , MuW1t];
    %***********test Clutter************
    BBCt = repmat(B1,NCtest,1);
    A_clt = cluttertest.*BBCt;
    A0_clt = sum(A_clt>0,2);
    MuB2t = sum(A_clt,2)./A0_clt;
    
    WWCt = repmat(W1,NCtest,1);
    AA_clt = cluttertest.*WWCt;
    AA0_clt=sum(AA_clt>0,2);
    MuW2t=sum(AA_clt,2)./AA0_clt;
    Mu2t=[MuB2t , MuW2t];
    %*****************************
    Fft=Mu1t*Wh;
    [aft bft] =find(Fft<te_op);
    Negt=aft;
    
    
    Fct=Mu2t*Wh;
    [act bct] =find(Fct>te_op);
    Post = act;
    
    %     error_ft=sum(Fft<te_op)/Ntest;
    %     error_ct=sum(Fct>te_op)/NCtest;
    %     errt=norm([error_ft error_ct],'inf');
    %     errort(ii)=min(errt);
    
    Acc(ii) = (sum(Ff>te_op)+sum(Fc<te_op))/(Ntrain+NCtrain);
    Acct(ii) = (sum(Fft>te_op)+sum(Fct<te_op))/(Ntest+NCtest);
    
    ii=ii+1;
    
end
%% figures

figure(1)
imshow(filter);
title('The filter')

figure(2)
plot(MuB2,MuW2,'.r','markerfacecolor'...
    ,[1,0,0],'markersize',15,'linewidth',2)
hold on
plot(MuB1,MuW1,'ob',...
    'markersize',8,'linewidth',2)
grid on
xlim([0,1])
ylim([0,1])
set(gca,'FontSize',12)

plot(m21,m22,'og', 'markersize',12,'markerfacecolor'...
    ,[0, 1, 0],'linewidth',4)

plot(m11,m12,'og','linewidth',4,...
    'markersize',12)
title(' Distribution of mean measurement of images for train')

% border ploting
x = 0:0.1:1;
y=(te_op - Wh(1)*x)/Wh(2);
hold on
plot(x, y,'-k','linewidth',2)
hold off
legend('clutter points','face points','mean of clutters','mean of faces',...
    'decision boundary','Location', 'best')



figure(3)
plot(MuB1t,MuW1t,'sb')
xlim([0,1])
ylim([0,1])
hold on
plot(MuB2t,MuW2t,'or')
xlim([0,1])
ylim([0,1])
title('Distribution of mean measurement of images for test')

%border ploting
x = 0:0.1:1;
y=(te_op - Wh(1)*x)/Wh(2);
hold on
plot(x, y,'-k','linewidth',2)
hold off
legend('clutter points','face points','decision boundary',...
    'Location', 'best')


figure(4)
plot(Acct,'-r')

hold on
plot(Acc,'-g')
title('accuracy of train and test for each iteration ')
