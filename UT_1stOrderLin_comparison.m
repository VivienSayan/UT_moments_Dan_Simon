clear all;
clc;

% sample number
ns = 10000;

% radius mean
rmean = ones(ns,1);
rsigma = 0.01;
r = rmean + rsigma*randn(ns,1);

% orientation mean
thmean = pi/2*ones(ns,1);
thsigma = 0.35;
th = thmean + thsigma*randn(ns,1);

% cartesian coordinates
y1 = r.*cos(th);
y2 = r.*sin(th);
y = [y1,y2];

figure();
plot(y1,y2,".");
xlabel("y1");
ylabel("y2");
grid on;
hold on;

% cartesian real mean
y1mean = mean(y(:,1));
y2mean = mean(y(:,2));
ybar = [y1mean*ones(ns,1), y2mean*ones(ns,1)];

% cartesian real covariance
Py1 = mean( (y(:,1)-ybar(:,1)).^2 );
Py2 = mean( (y(:,2)-ybar(:,2)).^2 );
Py1y2 = mean( (y(:,1)-ybar(:,1)).*(y(:,2)-ybar(:,2)) );
P = [Py1, Py1y2;
    Py1y2, Py2];

% linearized covariance
Pfalse = [thsigma^2,0;
          0, rsigma^2];

draw_ellipse([y1mean;y2mean],P,0.9,"green",1);
draw_ellipse([0;1],Pfalse,0.9,"red",1);

% Unscented Transformation
n = 2;

% first  a posteriori knowledge
xbar = [rmean(1,1);thmean(1,1)];
Prth = [rsigma^2,0;0,thsigma^2];

% sigma points
X1 = xbar + sqrt(n)*sqrt(Prth(1,:)'); 
X2 = xbar + sqrt(n)*sqrt(Prth(2,:)');
X3 = xbar - sqrt(n)*sqrt(Prth(1,:)');
X4 = xbar - sqrt(n)*sqrt(Prth(2,:)');

% propagate the sigma points
Y1 = [X1(1)*cos(X1(2)); 
      X1(1)*sin(X1(2))];
Y2 = [X2(1)*cos(X2(2));
      X2(1)*sin(X2(2))];
Y3 = [X3(1)*cos(X3(2));
      X3(1)*sin(X3(2))];
Y4 = [X4(1)*cos(X4(2));
      X4(1)*sin(X4(2))];
  
  % mean and covariance of the propagated sigma points
Ybar = (Y1+Y2+Y3+Y4)/(2*n); 
Pu = ( (Y1-Ybar)*(Y1-Ybar)' + (Y2-Ybar)*(Y2-Ybar)' + (Y3-Ybar)*(Y3-Ybar)' + (Y4-Ybar)*(Y4-Ybar)' ) / (2*n);

draw_ellipse(Ybar,Pu,0.9,"blue",1);

legend("samples","real covariance","linearized","Unscented Transformation")