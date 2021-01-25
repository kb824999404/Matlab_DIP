% Contrast-limited adaptive histogram equalization
% I is the input image

% numTiles: Two-element vector of positive integers: [M N]
% [M N] specifies the number of tile rows and columns.

% normClipLimit: Real scalar from 0 to 1
% limits contrast enhancement.
function out = my_clahe(I,numTiles,normClipLimit)

% intensity size
numBins = 256;

[I, numTiles, dimTile, clipLimit, noPadRect] = preprocess(I,numTiles,normClipLimit,numBins);

tileMappings = makeTileMappings(I, numTiles, dimTile, numBins,clipLimit);

out = makeClaheImage(I, tileMappings, numTiles,dimTile);  

if ~isempty(noPadRect) %remove padding
  out = out(noPadRect.ulRow:noPadRect.lrRow, ...
            noPadRect.ulCol:noPadRect.lrCol);
end

end
%-----------------------------------------------------------------------------
%% This function pre-process the inputs
function [I, numTiles, dimTile, clipLimit, noPadRect] = preprocess(I,numTiles,normClipLimit,numBins)

dimI = size(I);
dimTile = ceil(dimI ./ numTiles);

%check if the image needs to be padded; pad if necessary;
%padding occurs if any dimension of a single tile is an odd number
%and/or when image dimensions are not divisible by the selected 
%number of tiles
rowDiv  = mod(dimI(1),numTiles(1)) == 0;
colDiv  = mod(dimI(2),numTiles(2)) == 0;

if rowDiv && colDiv
  rowEven = mod(dimTile(1),2) == 0;
  colEven = mod(dimTile(2),2) == 0;  
end

noPadRect = [];
if  ~(rowDiv && colDiv && rowEven && colEven)
  padRow = 0;
  padCol = 0;
  
  % chick if image dimensions are not divisible by the number tiles
  if ~rowDiv
    rowTileDim = floor(dimI(1)/numTiles(1)) + 1;
    padRow = rowTileDim*numTiles(1) - dimI(1);
  else
    rowTileDim = dimI(1)/numTiles(1);
  end
  
  if ~colDiv
    colTileDim = floor(dimI(2)/numTiles(2)) + 1;
    padCol = colTileDim*numTiles(2) - dimI(2);
  else
    colTileDim = dimI(2)/numTiles(2);
  end
  
  %check if tile dimensions are even numbers
  rowEven = mod(rowTileDim,2) == 0;
  colEven = mod(colTileDim,2) == 0;
  
  if ~rowEven
    padRow = padRow+numTiles(1);
  end

  if ~colEven
    padCol = padCol+numTiles(2);
  end
  
  % caculate four padding size
  padRowPre  = floor(padRow/2);
  padRowPost = ceil(padRow/2);
  padColPre  = floor(padCol/2);
  padColPost = ceil(padCol/2);
  
  I = padarray(I,[padRowPre  padColPre ],'symmetric','pre');
  I = padarray(I,[padRowPost padColPost],'symmetric','post');

  %UL corner (Row, Col), LR corner (Row, Col)
  noPadRect.ulRow = padRowPre+1;
  noPadRect.ulCol = padColPre+1;
  noPadRect.lrRow = padRowPre+dimI(1);
  noPadRect.lrCol = padColPre+dimI(2);
end

dimI = size(I);
%size of the single tile
dimTile = dimI ./ numTiles;

numPixInTile = prod(dimTile);
minClipLimit = ceil(numPixInTile/numBins);
clipLimit = minClipLimit + round(normClipLimit*(numPixInTile-minClipLimit));

end
%-----------------------------------------------------------------------------


%-----------------------------------------------------------------------------
%% This function make tile mappings
function [tileMappings] = makeTileMappings(I, numTiles, dimTile, numBins,clipLimit)

numPixInTile = prod(dimTile);

tileMappings = cell(numTiles);

% extract and process each tile
imgCol = 1;
for col=1:numTiles(2)
  imgRow = 1;
  for row=1:numTiles(1)
    tile = I(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1);

    % get the histogram of the tile
    tileHist = my_imhist(tile); 
    
    % clip the histogram
    tileHist = clipHistogram(tileHist, clipLimit, numBins);
    
    % caculate the mapping function of the histogram
    tileMapping = makeMapping(tileHist,numPixInTile, numBins);
    tileMappings{row,col} = tileMapping;

    imgRow = imgRow + dimTile(1);    
  end
  imgCol = imgCol + dimTile(2); % move to the next column of tiles
end


end
%-----------------------------------------------------------------------------



%-----------------------------------------------------------------------------
% This function clips the histogram according to the clipLimit and
% redistributes clipped pixels across bins below the clipLimit

function imgHist = clipHistogram(imgHist, clipLimit, numBins)

% total number of pixels overflowing clip limit in each bin
totalExcess = sum(max(imgHist - clipLimit,0));  

% clip the histogram and redistribute the excess pixels in each bin
avgBinIncr = floor(totalExcess/numBins);
upperLimit = clipLimit - avgBinIncr; % bins larger than this will be
                                      % set to clipLimit

% this loop should speed up the operation by putting multiple pixels
% into the "obvious" places first
for k=1:numBins
  if imgHist(k) > clipLimit
    imgHist(k) = clipLimit;
  else
    if imgHist(k) > upperLimit % high bin count
      totalExcess = totalExcess - (clipLimit - imgHist(k));
      imgHist(k) = clipLimit;
    else
      totalExcess = totalExcess - avgBinIncr;
      imgHist(k) = imgHist(k) + avgBinIncr;      
    end
  end
end

% this loops redistributes the remaining pixels, one pixel at a time
k = 1;
while (totalExcess ~= 0)
  %keep increasing the step as fewer and fewer pixels remain for
  %the redistribution (spread them evenly)
  stepSize = max(floor(numBins/totalExcess),1);
  for m=k:stepSize:numBins
    if imgHist(m) < clipLimit
      imgHist(m) = imgHist(m)+1;
      totalExcess = totalExcess - 1; %reduce excess
      if totalExcess == 0
        break;
      end
    end
  end
  
  k = k+1; %prevent from always placing the pixels in bin #1
  if k > numBins % start over if numBins was reached
    k = 1;
  end
end
  
end
%-----------------------------------------------------------------------------


%-----------------------------------------------------------------------------
% This function caculate the mapping function of the histogram
function mapping = makeMapping(imgHist, numPixInTile, numBins)

mapping=zeros(1, numBins);

sum_count=0;
for i=1:numBins
    sum_count=sum_count+imgHist(i,1);
    mapping(1,i)=round(sum_count*(numBins-1)/numPixInTile);
end

end
%-----------------------------------------------------------------------------



%-----------------------------------------------------------------------------
% This function interpolates between neighboring tile mappings to produce a 
% new mapping in order to remove artificially induced tile borders.  

function claheI = makeClaheImage(I, tileMappings, numTiles,dimTile)

%initialize the output image to zeros (preserve the class of the input image)
claheI = I;
claheI(:) = 0;

[M,N]=size(I);

for i=1:M
  for j=1:N
    % four coners  
    if i <= ceil(dimTile(1)/2) && j <= ceil(dimTile(2)/2)
      tile_i = 1;
      tile_j = 1;
      claheI(i,j)= tileMappings{tile_i,tile_j}(1,I(i,j)+1);
    elseif i <= ceil(dimTile(1)/2) && j >= (numTiles(2)-1)*dimTile(2) + ceil(dimTile(2)/2)
      tile_i = 1;
      tile_j = numTiles(2);
      claheI(i,j)= tileMappings{tile_i,tile_j}(1,I(i,j)+1);
    elseif i >= (numTiles(1)-1)*dimTile(1) + ceil(dimTile(1)/2) && j <= ceil(dimTile(2)/2)
      tile_i = numTiles(1);
      tile_j = 1;
      claheI(i,j)= tileMappings{tile_i,tile_j}(1,I(i,j)+1);
    elseif i >= (numTiles(1)-1)*dimTile(1) + ceil(dimTile(1)/2) && ...
      j >= (numTiles(2)-1)*dimTile(2) + ceil(dimTile(2)/2)
      tile_i = numTiles(1);
      tile_j = numTiles(2);
      claheI(i,j)= tileMappings{tile_i,tile_j}(1,I(i,j)+1);
    % four edges except coners  
    elseif i <= ceil(dimTile(1)/2)
      % left
      % Linear interpolation
      tile_i = 1;
      tile_j = ceil((j-ceil(dimTile(2)/2))/dimTile(2));
      tile_up = [tile_i,tile_j];
      tile_down = [tile_i,tile_j + 1];
      p = (j - (tile_j-1)*dimTile(2) - ceil(dimTile(2)/2)) / dimTile(2);
      q = 1-p;
      [tileMapping_up]=tileMappings{tile_up};
      [tileMapping_down]=tileMappings{tile_down};
      claheI(i,j)= q*tileMapping_up(1,I(i,j)+1)+p*tileMapping_down(1,I(i,j)+1);
    elseif i >= (numTiles(1)-1)*dimTile(1) + ceil(dimTile(1)/2) 
      % right
      % Linear interpolation
      tile_i = numTiles(1);
      tile_j = ceil((j-ceil(dimTile(2)/2))/dimTile(2));
      tile_up = [tile_i,tile_j];
      tile_down = [tile_i,tile_j + 1];
      p = (j - (tile_j-1)*dimTile(2) - ceil(dimTile(2)/2)) / dimTile(2);
      q = 1-p;
      [tileMapping_up]=tileMappings{tile_up};
      [tileMapping_down]=tileMappings{tile_down};
      claheI(i,j)= q*tileMapping_up(1,I(i,j)+1)+p*tileMapping_down(1,I(i,j)+1);
    elseif j <= ceil(dimTile(2)/2)
      % up
      % Linear interpolation
      tile_i = ceil((i-ceil(dimTile(1)/2))/dimTile(1));
      tile_j = 1;
      tile_left = [tile_i,tile_j];
      tile_right = [tile_i + 1,tile_j];
      p = (i - (tile_i-1)*dimTile(1) - ceil(dimTile(1)/2)) / dimTile(1);
      q = 1-p;
      [tileMapping_left]=tileMappings{tile_left};
      [tileMapping_right]=tileMappings{tile_right};
      claheI(i,j)= q*tileMapping_left(1,I(i,j)+1)+p*tileMapping_right(1,I(i,j)+1);
    elseif j >= (numTiles(2)-1)*dimTile(2) + ceil(dimTile(2)/2)
      % down
      % Linear interpolation
      tile_i = ceil((i-ceil(dimTile(1)/2))/dimTile(1));
      tile_j = numTiles(2);
      tile_left = [tile_i,tile_j];
      tile_right = [tile_i + 1,tile_j];
      p = (i - (tile_i-1)*dimTile(1) - ceil(dimTile(1)/2)) / dimTile(1);
      q = 1-p;
      [tileMapping_left]=tileMappings{tile_left};
      [tileMapping_right]=tileMappings{tile_right};
      claheI(i,j)= q*tileMapping_left(1,I(i,j)+1)+p*tileMapping_right(1,I(i,j)+1);
    else
      % middle area
      % Bilinear interpolation
      tile_i = ceil((i-ceil(dimTile(1)/2))/dimTile(1));
      tile_j = ceil((i-ceil(dimTile(2)/2))/dimTile(2));
      tile_1 = [tile_i,tile_j];
      tile_2 = [tile_i+1,tile_j];
      tile_3 = [tile_i,tile_j+1];
      tile_4 = [tile_i+1,tile_j+1];
      u = (i - (tile_i-1)*dimTile(1) - ceil(dimTile(1)/2)) / dimTile(1);
      v = (j - (tile_j-1)*dimTile(2) - ceil(dimTile(2)/2)) / dimTile(2);
      [tileMapping_1]=tileMappings{tile_1};
      [tileMapping_2]=tileMappings{tile_2};
      [tileMapping_3]=tileMappings{tile_3};
      [tileMapping_4]=tileMappings{tile_4};
      claheI(i,j) = u*v*tileMapping_4(1,I(i,j)+1) + ...
                    (1-u)*(1-v)*tileMapping_1(1,I(i,j)+1) + ...
                    u*(1-v)*tileMapping_2(1,I(i,j)+1) + ...
                    (1-u)*v*tileMapping_3(1,I(i,j)+1);
    end
  end
end

end
%-----------------------------------------------------------------------------


