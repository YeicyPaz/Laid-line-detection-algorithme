function f_H = ss_freq_tv_filter_color( Phi, H, f_r )
% private function by Guy Gilboa
% Construct color filtered image from Phi, filter H and residual image f_r
% Example: f_H = ss_freq_tv_filter( Phi, H, f_r )

f_H = f_r;
for i=1:length(H),
    f_H = f_H+H(i)*Phi(:,:,:,i);
end % for i

end

