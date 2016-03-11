function A = phytoconvert(varargin)
%PHYTOCONVERT Conversion factors for phytoplankton unit conversions
%
% A = phytoconvert
% A = phytoconvert(ratio)
%
% This function just returns the typical values I use for converting
% between element-based biogeochemical units and wet weight-based fisheries
% ones.
%
% Input variables:
%
%   ratio:  source for N/C ratio
%           'redfield':     Redfield et al. 1963 (default)
%           'anderson':     Anderson and Sarmiento 1994
%           'ecostoich':    not sure, possibly Ecological Stoiciometry
%                           book, need to check on this
%
% Output variables:
%
%   A:  1 x 1 structure with fields:
%
%       wwCfrac:    fraction of phytoplankton wet weight composed of
%                   carbon, i.e. g C/g ww
%
%       c2n:        mol N/mol C for phytoplankton, see options above
%
%       cmw:        molecular weight of carbon (i.e. g C/mol C)
%
%       yr2s:       seconds per year
%
%       moln2gc:    g C/mol N, based on the above factors
%
%       moln2gww:   g wet weight/mol N, based on the above factors

% Copyright 2009 Kelly Kearney

% wwCfrac is based on tables citing Strickland 1966, 

A.wwCfrac = 1/12;      % C/wet weight for phytoplankton*

% *I took this number from the O'Reilly and Dow pamphlet that came up under
% a Google search for "phytoplankton wet weight" (un-bibdesked).  That
% pamphlet cites Strickland 1966, "Measuring the production of marine
% phytoplankton.", a bulletin published through the Fisheries Research
% Board of Canada (Ottawa) that seems to be out of print now.  But the
% above pamphlet quoted a section of it and then offered that "10-12 mg
% algal weight:mg C is the most suitable factor for estimating
% phytoplankton biomass as "wet weight"".  Strickland provided a range of
% 6.7-11.1 mg ww:mg C.  I'm erring on the lower side, simply because Aydin
% and others have assumed so much lower a number for C/ww (1% C).

if nargin < 1
    ratio = 'redfield';
else
    ratio = varargin{1};
end

switch ratio
    case 'redfield'     % Redfield et al. 1963
        A.c2n = 16/106;
    case 'anderson'     % Anderson and Sarmiento 1994
        A.c2n = 16/117;
    case 'ecostoich'    % I had this in here for a while, but have no idea where I got it from... maybe Ecological Stoichiometry?
        A.c2n = 17/133;
    otherwise
        error('Unknown ratio option');
end
          
A.cmw = 12.0107;        % C molecular weight
A.yr2s = 3600*24*365;   % sec/year

A.moln2gc = A.cmw/A.c2n;     % g C/mol N
A.moln2gww = A.cmw/(A.c2n*A.wwCfrac); % g wet weight/mol N 

