function [R S t] = intrinsic_images( I, lambda )
% I: input
% lambda: control the smoothness
% R: Reflectance;
% S: Shading;

%% Initialization
I_t = ones(size(I));
I_t(I<1) = I(I<1);
I_t(I_t<=1/256) = 1/256;
I_log = log(I_t);
S = size(I_log);
size_wh = S(1,1:2);
dim_repmat = [1 1 S(1,3)];
filter1 = [1 -1];
filter2 = [1; -1];
filter3 = [0 -1 0; -1 4 -1; 0 -1 0];

%% Pre-computing
nor1 = imfilter(I_log,filter3,'circular');
nor1 = fft2(imfilter(nor1,filter3,'circular'));
den1 = repmat(abs(psf2otf(filter3,size_wh)).^2,dim_repmat) ;
den2 = repmat(abs(psf2otf(filter1,size_wh)).^2 + ...
    abs(psf2otf(filter2,size_wh)).^2,dim_repmat);

%% MAIN PROCEDURE
tic

R = I_log;
low_b = log(1/256)*ones(S);
up_b = zeros(S);
beta = 1;
wt = 1e-3;
eps = 1e-16;
iter_max = 5;

while iter_max
    iter_max = iter_max - 1;
    
    %% update g
    g1 = -imfilter(R,filter1,'circular');
    g1_mean = repmat(mean(g1,3),dim_repmat);
    temp1 = and(sum((g1_mean.^2),3)<1/beta,...
        sum(((g1 - g1_mean).^2),3)<wt/beta);
    g1(repmat(temp1,dim_repmat))=0; 
    
    g2 = -imfilter(R,filter2,'circular'); 
    g2_mean = repmat(mean(g2,3),dim_repmat);
    temp2 = and(sum((g2_mean.^2),3)<1/beta,...
        sum(((g2 - g2_mean).^2),3)<wt/beta);
    g2(repmat(temp2,dim_repmat))=0; 

    %% Compute & normalize R
    nor2 = [g1(:,end,:) - g1(:, 1,:), -diff(g1,1,2)] +...
        [g2(end,:,:) - g2(1, :,:); -diff(g2,1,1)];
    den   = lambda*den1 + beta*den2 + eps;
    nor = lambda*nor1 + beta*fft2(nor2);
    R = real(ifft2(nor./den));
    
    for i = 1:dim_repmat(1,3)
        R_t = R(:,:,i);
        max_iteration = 300;
        threshold = 1/numel(R_t);
        while max_iteration
            max_iteration = max_iteration - 1;
            dt_nor = sum(R_t(R_t>0)) + sum(R_t(R_t<log(1/256)) - log(1/256));
            dt = -dt_nor/numel(R_t);
            R_t = R_t+dt;
            if abs(dt)<threshold
                break; 
            end
        end
        R(:,:,i) = R_t;
    end
    
    R(R<low_b) = low_b(R<low_b);
    R(R>up_b) = up_b(R>up_b);
    
    beta = beta * 2;
end

R = exp(R);
S = mean(I./R,3);
t = toc;
end


