c=3*10^8;
lam=1560;%��λnm
fc=c/(lam*10^(-9));
wc=2*pi*fc*10^(-12);%��λrad*ps^(-1)
% fsigpul=2.746*10^12/2.355;%��λHz
frep=50*10^6;%��λHz
Trep=1/frep*10^12;%��λps
fceo=100*10^6;
Tceo=1/fceo*10^12;%��λps
wceo=2*pi*fceo*10^(-12);%��λͬwc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ftmin=-450;
ftmax=450;
fdt=1;
ft=ftmin:fdt:ftmax;%��λfs

ftn=length(ft);
fE=zeros(1,ftn);
E=zeros(1,ftn);
ftfs=ft*10^(-15);

ftsigpul=zeros(1,51);
ftsi=1;
for fsigpul=0.016*10^12:0.2*10^12:10.016*10^12
    %%%\Ƶ��ģ%%%
    fr=fc-3.5*10^12:frep:fc+3.5*10^12;
    frn=length(fr);
    fbao=(1/((2*pi)^0.5*fsigpul))*exp(-(fr-fc).^2/(2*fsigpul^2));
    
    %%%%%%%%%%%%%%%%%%%�ϳ�%%%%%%%%%%%%%%%%%%%%%%%
    for frr=1:frn
        fE=fbao(frr)*cos(2*pi*fr(frr)*ftfs);%��ʱft��λΪfs��
        E=E+fE;
    end;
    %%%%%%%%%%%�����%%%%%%%%%%%%%
    Ebao=zeros(1,ftn);
    for ftbao=1:ftn
        Ebao(ftbao)=E(ftbao)/(cos(2*pi*fc*ftfs(ftbao)));
    end;
    
    %%%%%%%%%%%%%�����%%%%%%%%%%%%%%%
    tmaxhalf=0.5*max(Ebao);
    EEbao=abs(Ebao-tmaxhalf);
    half=(ftn-1)/2;
    [ezuo,tzuo]=min(EEbao(1:half));
    [eyou,tyou]=min(EEbao(half+1:ftn));
    ftsigpul(ftsi)=ft(half+tyou)-ft(tzuo);
    ftsi=ftsi+1;
end;
fsigpul=0.016*10^12:0.2*10^12:10.016*10^12;%��λHz
%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%
% fts=ft/1000;%��λps
% subplot(2,1,1)
% plot(fts,Ebao);grid;
% xlabel('ʱ��/ps');
% ylabel('���');
% hold on;
% subplot(2,1,2)
plot(fsigpul,ftsigpul);grid;
xlabel('Ƶ���߿�/Hz');
ylabel('ʱ��������/fs');