%Target and anchor placement
function [phi,alpha]=place(side,nNodes,nAnchors)
spacing=1/(2*sqrt(nNodes)-2);
phi1=0:2*spacing:1;
phi2=0:2*spacing:1;


phi=rand(2,nNodes)*side;
%alpha=[[0;0.5] [0.5;0] [1;0.5] [0.5;1]]*side;
%alpha=[[0;0] [0;1] [1;0] [1;1]]*side;

% alpha=rand(2,nAnchors)*side;
% phi=combvec(phi1,phi2)*side;

if nAnchors==4
    alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]]*side;
    %alpha=[[0;1] [1;0] [0;0] [1;1]]*side;
    %alpha=[[0.33;0.33] [0.33;0.66] [0.66;0.33] [0.66;.66]]*side;%rmse=3.9-4.5
    %alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]]*side;
    %alpha=[[0;0.5] [0.5;0] [1;0.5] [0.5;1]]*side;
    
elseif nAnchors==8
    alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]...
        [0;0] [1;0] [1;1] [0;1]]*side;
    %     alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]...
    %         [0;0.5] [0.5;0] [1;0.5] [0.5;1]]*side;
    %     alpha=side*([[3*spacing;3*spacing] [15*spacing;3*spacing] [3*spacing;15*spacing] [15*spacing;15*spacing]...
    %         [7*spacing;7*spacing] [11*spacing;7*spacing] [7*spacing;11*spacing] [11*spacing;11*spacing]]);
    %     alpha1=3*spacing:12*spacing:1;
    %     alpha2=3*spacing:12*spacing:1;
    %     alphaa=combvec(alpha1,alpha2)*side;
    %     alphab=side*([[9*spacing;spacing] [9*spacing;17*spacing] [5*spacing;9*spacing] [13*spacing;9*spacing]]);
    %     alpha=[alphaa alphab];
elseif nAnchors==12
    alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]...
        [0;0] [1;0] [1;1] [0;1]...
        [0;0.33] [0;0.66] [0.33;0] [0.66;0]]*side;
    %     alpha1=5*spacing:8*spacing:1;
    %     alpha2=spacing:8*spacing:1;
    %     alpha=combvec(alpha1,alpha2)*side;
    %     alpha1=spacing:8*spacing:1;
    %     alpha2=5*spacing:8*spacing:1;
    %     alpha=[alpha combvec(alpha1,alpha2)*side];
elseif nAnchors==16
    alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]...
        [0;0] [1;0] [1;1] [0;1]...
        [0;0.33] [0;0.66] [0.33;0] [0.66;0] [1;0.33] [1;0.66] [0.33;1] [0.66;1]]*side;
    %     alpha1=3*spacing:4*spacing:1;
    %     alpha2=3*spacing:4*spacing:1;
    %     alpha=combvec(alpha1,alpha2)*side;
elseif nAnchors==20
    alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]...
        [0;0] [1;0] [1;1] [0;1]...
        [0;0.33] [0;0.66] [0.33;0] [0.66;0] [1;0.33] [1;0.66] [0.33;1] [0.66;1]...
        [0;0.5] [0.5;0] [1;0.5] [0.5;1]]*side;
    %     alpha=[[0.25;0.25] [0.75;0.25] [0.25;0.75] [0.75;.75]...
    %         [0;0] [1;0] [1;1] [0;1]...
    %         [0;0.33] [0;0.66] [0.33;0] [0.66;0] [1;0.33] [1;0.66] [0.33;1] [0.66;1]...
    %         [0.33;0.33] [0.33;0.66] [0.66;0.33] [0.66;.66]]*side;
    %     alpha1=spacing:4*spacing:1;
    %     alpha2=3*spacing:4*spacing:1;
    %     alpha=combvec(alpha1,alpha2)*side;
end


end