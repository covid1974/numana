f = function(x) {
    temp = x*x;
    -asin((1-temp)/(1+temp))-x;
}

et = function(b,n) {
  h = b/n;
  x = rep(0,n+1);
  y =  rep(0,n+1);
  eul =  rep(0,n+1);
  tay =  rep(0,n+1);
  x[1] = 0;
  eul[1] = tay[1] = -pi/2;

  for(i in 2:(n+1)) {  
    x[i] = x[i-1] + h;

    D0 = eul[i-1];
    D1 = -sin(x[i-1]+D0);

    eul[i] = D0 + h*D1;
    
    D0 = tay[i-1];
    D1 = -sin(x[i-1]+D0);
    D2 = -cos(x[i-1]+D0)*(1+D1)
    tay[i] = D0 + h*D1 +h*h*D2/2;
  }
  return(list(x=x,eul=eul,tay=tay))
}

b=2
xhi = seq(0,b,len=100)
yhi = f(xhi)
result=et(b,10)
png('image/et2_10.png')
plot(xhi,yhi,xlab="x", ylab="y", type="l", lty=1,xlim=c(0,b),ylim=range(yhi,result$eul,result$tay));
lines(result$x,result$eul,lty=2);
lines(result$x,result$tay,col='red');
dev.off()

leg  = function() {
  legend(locator(),leg=c("True","Euler","Taylor2"),lty=1:3)
}


