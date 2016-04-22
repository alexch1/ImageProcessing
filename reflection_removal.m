function [LB LR t] = reflection_removal( I, lambda )
% I: The input image which will be divided into two layers;
% lambda: control the smoothness
% LB: Backgroud Layer;
% LR: Reflection Layer;

%% Initialization
S = size(I);
size_wh = S(1,1:2);
dim_repmat = [1 1 S(1,3)];
filter1 = [1 -1];
filter2 = [1; -1];
filter3 = [0 -1 0; -1 4 -1; 0 -1 0];

%% Pre-computing
nor1 = repmat(abs(psf2otf(filter3,size_wh)),dim_repmat).^2.*fft2(I);
den1 = repmat(abs(psf2otf(filter3,size_wh)).^2,dim_repmat) ;
den2 = repmat(abs(psf2otf(filter1,size_wh)).^2 + ...
    abs(psf2otf(filter2,size_wh)).^2,dim_repmat);


%% MAIN PROCEDURE
tic

low_b = zeros(S);
up_b = I;
eps = 1e-16;
beta = 20;
LB = I;
iter_max = 5;

while iter_max
    iter_max = iter_max - 1;
    %% Update g
    g1 = -imfilter(LB,filter1,'circular');
    g1(repmat(sum(abs(g1),3)<1/beta,dim_repmat)) = 0;
    g2 = -imfilter(LB,filter2,'circular');
    g2(repmat(sum(abs(g2),3)<1/beta,dim_repmat)) = 0;

    %% Compute & Normalize LB
    nor2 = [g1(:,end,:) - g1(:, 1,:), -diff(g1,1,2)] +...
        [g2(end,:,:) - g2(1, :,:); -diff(g2,1,1)];
    nor = lambda*nor1 + beta*fft2(nor2);
    den = lambda*den1 + beta*den2 + eps;
    LB = real(ifft2(nor./den));
    
    for i = 1:dim_repmat(1,3)
        
        LB_t = LB(:,:,i);
        max_iteration = 100;
        threshold = 1/numel(LB_t);
        
        while max_iteration
            max_iteration = max_iteration - 1;
            dt_nor = sum(LB_t(LB_t<low_b(:,:,i)));
            dt = -2*(dt_nor + sum(LB_t(LB_t>up_b(:,:,i))))/numel(LB_t);
            LB_t = LB_t + dt;
            if abs(dt) < threshold
                break;
            end   
        end
        
        LB(:,:,i) = LB_t;
        
    end
    LB(LB<low_b) = low_b(LB<low_b);
    LB(LB>up_b) = up_b(LB>up_b);
    
    beta = beta * 2;
end

LR = I - LB;
t = toc;
end

