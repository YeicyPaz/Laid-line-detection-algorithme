function I = ss_freq_tv_show_color_phi( Phi,Ind, RbyC, fignum, Rescale, Mask,params)
if (~exist('Mask','var'))
    Mask=ones(size(Phi,1),size(Phi,2),size(Phi,3));
end
if (~exist('Rescale','var'))
    Rescale = 1;
end
if (~exist('params','var'))
    params = [1.5 0.5];
end
% show combined phi's of color images on screen 
Nr = RbyC(1);
Nc = RbyC(2);
Rs = Rescale;

phi = imresize(Phi(:,:,:,1),Rs,'nearest');
Ny = size(phi,1);
Nx = size(phi,2);
mul = params(1);
offset = params(2);

figure(fignum);

I = zeros(Nr*Ny+(Nr+1)*2,Nc*Nx+(Nc+1)*2,size(Phi,3));
cnt = 1;
for j=1:Nr,
    for i=1:Nc,
        phi = imresize(Mask.*Phi(:,:,:,Ind(cnt)),Rs,'nearest');
        if (mul>0)
            phi = mul*phi+offset;
        else
            phi = phi/max(abs(phi(:)))+offset;
        end
        I(j*(Ny+2)-Ny+1:j*(Ny+2),i*(Nx+2)-Nx+1:i*(Nx+2),:)=phi;
        cnt = cnt+1;
    end % for i
end % for j
imshow(I);

end

