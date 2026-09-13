function [S,T,Phi,f_r] = ss_freq_tv_evolve_color(f, Max_time, dt, Method)
% private function by Guy Gilboa (June 2013)
% Computes TV spectrum of color images, returns S, time interval T, Phi(T)
% and residual image f_r (to be added in the reconstruction).
% Method is an optional struct specifying numerical method and params
% Example: [S,T,Phi] = ss_freq_tv_evolve(f, Max_time, dt)
% Computing ROF for color is based on: Bresson, X., & Chan, T. F. (2008). Fast dual minimization of the vectorial total variation norm and applications to color image processing. Inverse Problems and Imaging, 2(4), 455-484.
% Method is based on the papers:
% Based on: [1] G. Gilboa, “A spectral approach to total variation”, A. Kuijper et al. (Eds.): SSVM 2013, LNCS 7893, pp. 36--47. Springer, Heidelberg, 2013.
%           [2] G. Gilboa, “A total variation spectral framework for scale and texture analysis”, CCIT Report 833, Dept. of Electrical Engineering, Technion , June 2013.


% only 'proj' method at this stage
if exist('Method','var')
    Num_method = Method.Num_method;
    %if (strcmp(Num_method,'split_breg')) 
    %    tol  = Method.tol;
    %else
        dt_proj = Method.dt_proj;
        iter_proj = Method.iter_proj;
    %end    
else
    Num_method = 'proj'; % Projection algorithm, default        
    dt_proj=0.2; iter_proj=500; 
end    
%Num_method = 'proj'; % projection algorithm
%Num_method = 'split_breg'; % split bregman - not valid for color

% Split Bregman params
%if (strcmp(Num_method,'split_breg')) 
    % Split Bregman params:
%    addpath SplitBregman_Rice    
    %tol = 0.000001;
%end

%if (strcmp(Num_method,'proj')) 
%    % Projection algorithm params
%    dt_proj=0.2; iter_proj=500; 
%end

mu = 1/(2*dt);
NumIter = round(Max_time/dt);

S = zeros(1,NumIter); 
Phi = zeros(size(f,1),size(f,2),size(f,3),NumIter);
T = (1:NumIter)*dt;

u0 = f;
%if (strcmp(Num_method,'proj')) 
    u1=proj_tv_color(u0,mu,iter_proj,dt_proj);
    u2=proj_tv_color(u1,mu,iter_proj,dt_proj);
%else %split breg
%    u1 = splitBregmanROF(u0,mu,tol);
%    u2 = splitBregmanROF(u1,mu,tol);
%end

for i=1:NumIter,
    ddu = (u0+u2-2*u1)/dt;  % one/two more iter
    t = i*dt;
    phi = ddu*t;
    Phi(:,:,:,i) = phi;
    S(i) = sum(abs(phi(:)));
    if (i<NumIter) % not last iteration
        u0=u1;
        u1=u2;
        %if (strcmp(Num_method,'proj')) 
            u2=proj_tv_color(u2,mu,iter_proj,dt_proj);
        %else %split breg
        %    u2 = splitBregmanROF(u2,mu,tol);
        %end
    end

end % for i

f_r = (NumIter+1)*u1-NumIter*u2;  % residual image

end

