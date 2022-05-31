function [X_no_cnstnt, Y] = data_IPSJ1

filename = "data_IPSJ1.mat";

if exist(filename, "file")
    load(filename)
    return
end

%データセット2
% data1 = h5read('dsprites_ndarray_co1sh3sc6or40x32y32_64x64.hdf5','/imgs',[1 1 1],[64 64 737280]);
data1 = h5read('dsprites_ndarray_co1sh3sc6or40x32y32_64x64.hdf5', '/imgs');

% % target_1 = h5read('dsprites_ndarray_co1sh3sc6or40x32y32_64x64.hdf5','/latents/classes',[1 1],[6 737280]);
% % target_2 = h5read('dsprites_ndarray_co1sh3sc6or40x32y32_64x64.hdf5','/latents/values',[1 1],[6 737280]);
target_1 = h5read('dsprites_ndarray_co1sh3sc6or40x32y32_64x64.hdf5','/latents/classes');
% target_2 = h5read('dsprites_ndarray_co1sh3sc6or40x32y32_64x64.hdf5','/latents/values');

color       = 0; % 0 - 0
shape       = 0; % 0 - 2
scale       = 0; % 0 - 5 
orientation = 0; % 0 - 39 
position_x  = 0; % 0 - 31
position_y  = 0; % 0 - 31
%unique(target_1(1,:))
%データセット2

N = size(target_1, 2);
nums = 1 : N;

for roop = 1:9
    for n = 1:46
        i = nums(all(repmat([color; shape; 5; orientation; ...
            position_x; position_y], ...
            1, N) == target_1, 1));
%         C1(:,:,l) = data1(:,:,i);
        C1(:,:,l) = imresize(data1(:,:,i), 0.5);
        D1(:,l) = target_1(:, i);
        
        if l == 414
           break
        end

        l = l + 1;
        m = m + 1;

        shape = shape +1;

        if rem(m,3) == 0
            shape = 0;
            scale = scale + 2;
            if scale > 5
                scale = 0;
            end
        end

        if rem(m,46) >=1 && rem(m,46) <= 11
            position_x = position_x + 2;
        end

        if rem(m,46) >= 12 && rem(m,46) <= 23
            position_y = position_y + 2;
        end

        if rem(m,46) >= 24 && rem(m,46) <= 34
            position_x = position_x - 2;
        end

        if rem(m,46) >= 35 || rem(m,46) == 0
            position_y = position_y - 2;
        end
    end
end


cnt = 1;
for scale = 5 : -1 : 3
    for my_color = 0 : 2
        for shape = 0 : 2
            for position_x = 0 : 31 / 5 : 31
                for position_y = 0 : 31 / 5 : 31
                    i = nums(all(repmat([color; shape; scale; orientation; ...
                        round(position_x); round(position_y)], ...
                        1, N) == target_1, 1));

                    % ----- color -----
                    if my_color == 0
                        % white
%                         images(:, :, cnt)  = 255 * imresize(data1(:, :, i), 0.5);
                        images(:, :, cnt)  = 255 * data1(:, :, i);
                        Y(1, cnt) = 255;
                    elseif my_color == 1
                        % light gray
%                         images(:, :, cnt)  = 211 * imresize(data1(:, :, i), 0.5);
                        images(:, :, cnt)  = 211 * data1(:, :, i);
                        Y(1, cnt) = 211;
                    else
                        % dim gray
%                         images(:, :, cnt)  = 105 * imresize(data1(:, :, i), 0.5);
                        images(:, :, cnt)  = 105 * data1(:, :, i);
                        Y(1, cnt) = 105;
                    end
                    % -----------------

                    % ----- shape -----
                    Y(2, cnt) = shape;
%                     if shape == 0
%                         Y(3 : 4, cnt) = [0; 0];
%                     elseif shape == 1
%                         Y(3 : 4, cnt) = [0; 1];
%                     else
%                         Y(3 : 4, cnt) = [1; 0];
%                     end
                    % -----------------

                    % ----- scale -----
                    Y(3, cnt) = scale;
                    % -----------------

                    cnt = cnt + 1;
                end
            end
        end
    end
end

ns = size(images);
X = reshape(images, ns(1) * ns(2), ns(3));
X = im2double(X);

N = size(Y, 2);
Y = (Y - repmat(mean(Y, 2), 1, N)) ...
    ./ repmat(std(Y, 0, 2), 1, N); % normalization

constant_pixels = min(X') - max(X') == 0;

X_no_cnstnt = X(~constant_pixels, :);

save(filename, 'X_no_cnstnt', 'Y')

%

% figure(1)
% 
% cnt = 1;
% for i = 1:5:414
%     colormap(gray)
%     subplot(9,9,cnt)
%     imagesc(X(:,:,i))
%     title(num2str(i))
%     cnt=cnt+1;
%     daspect([1 1 1]);
% end
% %truesize


%{
N = size(X, 3);
for i = 1 : N
    colormap(gray)
    imagesc(X(:,:,i), [0, 255])
    title(num2str(i))
    frame = getframe(figure(1));
    im{i} = frame2im(frame);
    pause(.4)
    %truesize
end

filename = 'testAnimated_X.gif'; % Specify the output file name
for i = 1 : N
    [I, map] = rgb2ind(im{i},256);
    if i == 1
        imwrite(I, map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
    end
    imwrite(I, map,filename,'gif','WriteMode','append','DelayTime',0.1);
end
%}
