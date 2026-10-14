%here we fix the parameters
tau=1;
F=10;
E0=400;
sigma=45;

% we fix then a maximal time N (we think about it as number of seconds)
% on which we perform the experiment,
N=200;

% we define the function f as a line vector of dimension N
% Choice of f is made by trial and error as well as some inspired ideas. I
% cannot seem to go under 116 seconds, which is about 16 seconds above the
% world record for men indoor. This might be due to the model or to the
% values for effort I am using.
f=zeros(1,N);
for i=1:N
    if i<5
        f(i)=0.8*F;
    elseif i<50
        f(i)=0.72*F;
    elseif i<117
        f(i)=0.68*F;
    else
        f(i)=0.67*F;
    end
end

% we initialize the vectors containing speed, energy, and distance
D=zeros(1,N);
v=zeros(1,N);
E=zeros(1,N);
E(1)=E0;

%we fix the time at 0
t=0;

% we introduce some parameters that we need to go out of the loop
E_left=E0;
D_per=0;

% we go out of the loop if:
% 1. The energy left E_left is less than 0, in that case our athlete stops
% 2. The distance made D_per is more that 800
% 3. the time goes over our time limit N
% 4. we violate the confition on the force
while D_per<800 && E_left>0 && t<N && f(t+1)<F+1
    % we increase time
    t=t+1;
    % here we need to write a function that given the solution of the ode at
    % time t gives as the solution at time t+1. Use your favorite method.

    [D(t+1),v(t+1),E(t+1)]=solve(f, v(t), E(t), D(t), t, tau, sigma);
    % we upload the conditions to see if we have to go out of the loop
    D_per=D(t+1);
    E_left=E(t+1);
end

% we plot out results
figure(1)
plot(1:t+1,D(1:t+1))
legend('Distance')
figure(2)
plot(1:t+1,E(1:t+1))
legend('Energy')
figure(3)
plot(1:t+1,v(1:t+1))
legend('Speed')

% we write the time
if D_per>=800
    fprintf('your time was %f', t)
else
    fprintf('You did not make it to the end')
end

disp(trapz(v))
