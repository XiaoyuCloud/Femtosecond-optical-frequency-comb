c=3*10^8;
lam=1560;
fc=c/(lam*10^(-9));
wc=2*pi*fc*10^(-12)*10^(-3);%��λrad*fs^(-1)
sigpul=127.398;%��λfs
frep=50*10^6;%��λHz
Trep=1/frep*10^12*10^3;%��λfs
fceo=20*10^6;%��λHz
Tceo=1/fceo*10^12*10^3;%��λfs
wceo=2*pi*fceo*10^(-12)*10^(-3);%��λͬwc
%%��˹�������ز�%%%%%
tfmax=500;
t0=-tfmax;tf=tfmax;dt=0.05;fs=1/dt;%dt����ʱ�����Ƶ��Ϊ0.05fs��
t1=t0:dt:tf-dt;ts=0;
D=(1/(2*pi)^0.5*sigpul)*exp(-t1.^2/(2*sigpul^2));%���������˹����,������fs
E=exp(wc*t1*1i);
F=D.*E;%������������,������fs
FF=real(F);
f=length(F);
% plot(t1,FF);grid;
% axis([-200,200,min(FF),max(FF)]);
%%%%%%%%%%��״����%%%%%%%%%%
N=5;%���뼤�����������
NN=0;
phi0=2*pi*Trep/Tceo;
phi=NN*phi0;%��λ�ƶ�
% TTrep=3*tfmax*fs;%��λfs
TTrep=2*tfmax*fs+10000;%��λfs
B=zeros(1,N*TTrep);%�����꣬��λΪfs
for tt=1:N*TTrep%tt��λΪfs
    NN=fix(tt/(TTrep));
    phi=NN*phi0;
    if(rem(tt,TTrep)==1)
        B(tt)=1*exp(-phi*1i);
    end;
end;
b=length(B); 
BB=real(B);
plot(BB);
%%%%%%%�������ʱ����5����������%%%%%%%%
C=conv(F,B);%��λΪfs����ʱ��˹���粿�ֵ�λΪ0.01fs����˹�������˹����֮�䵥λΪfs
CC=C(1:b);%
c=length(CC);
tc=1:b;
TTTrep=20000*10^3;%��λfs
tcdet=(TTTrep-2*tfmax)/(TTrep-f);%��λfs
    for tcci=0:N-1%����
        for tcct=tcci*TTrep+1:tcci*TTrep+f
            tc(tcct)=tcci*TTTrep-tfmax+(tcct-tcci*TTrep)*dt;
        end;
        for tcct=tcci*TTrep+f+1:(tcci+1)*TTrep
            tc(tcct)=tcci*TTTrep+tfmax+(tcct-tcci*TTrep-f)*tcdet;
        end;
    end;
ttc=tc/1000;%��λps
CCB=real(C(1:b));
plot(ttc,CCB);grid;
% axis([19999,20001,min(FF),max(FF)]);