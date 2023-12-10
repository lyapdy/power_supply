clc;

iLin = out.iLin(:,2);
UCin = out.UCin(:,2);
iRout = out.iRout(:,2);
UCout = out.UCout(:,2);

deltaiLin = max(iLin(round(end*(1-2/f)):round(end*(1-0.5/f))))...
    - min(iLin(round(end*(1-2/f)):round(end*(1-0.5/f))));

deltaUCin = max(UCin(round(end*(1-2/f)):round(end*(1-0.5/f))))...
    - min(UCin(round(end*(1-2/f)):round(end*(1-0.5/f))));

deltaiRout = max(iRout(round(end*(1-2/f)):round(end*(1-0.5/f))))...
    - min(iRout(round(end*(1-2/f)):round(end*(1-0.5/f))));

deltaUCout = max(UCout(round(end*(1-2/f)):round(end*(1-0.5/f))))...
    - min(UCout(round(end*(1-2/f)):round(end*(1-0.5/f))));

deltaiLin
deltaUCin
deltaiRout
deltaUCout

meaniLin = mean(iLin(round(end*(1-1000/f)):end))
meanUCin = mean(UCin(round(end*(1-1000/f)):end))
meaniRout = mean(iRout(round(end*(1-1000/f)):end))
meanUCout = mean(UCout(round(end*(1-1000/f)):end))
