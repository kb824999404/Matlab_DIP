function g = intrans(f,varargin)
error(nargchk(2,4,nargin))
classin = class(f);
if strcmp(class(f),'double')& max(f(:))>1 & ...
        ~strcmp(varargin{1},'log')
    f = mat2gray(f);
else 
    f =im2double(f);
end
method=varargin{1};
switch method
    case 'neg'
        g=imcomplement(f);
    case 'log'
        if length(varargin) == 1
            c = 1;
        elseif length(varargin) == 2
            c = varargin{2};
        elseif length(varagin) == 3
            c = varargin{2};
            classin=varargin{3};
        else
            error('Incorret number of inputs for the log option.')
        end
        g = c*(log(1+double(f)));
    case 'gamma'
        if length(varargin) < 2
            error('Not enough inputs for the gamma option.')
        end
        gam = varargin{2};
        g = imadjust(f,[],[],gam);
    case 'stretch'
        if length(varargin) == 1
            m =mean2(f);
            E =4.0;
        elseif length(varargin)==3
            m =varargin{2};
            E =varargin{3};
        else error('Incorrect number of inputs for stretch option.')
        end
        g=1./(1+(m./(f+eps)).^E);
    otherwise
        error('Unknown enhancement method.')
end
g=changeclass(classin,g);