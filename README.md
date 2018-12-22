# Node localization in Wireless Sensor Network

[![MIT](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/kritiksoman/WSN-Localization/blob/master/LICENSE)

## Overview
This is the MATLAB implementation of the work presented in [RSS-Based Localization in WSNs Using Gaussian Mixture Model via Semidefinite Relaxation](https://ieeexplore.ieee.org/abstract/document/7847378/).

## Files
pathLossModel.m : Plot the path loss model and the histogram of the Gaussian Mixture Model <br/>
estimatePos.m : Returns the estimated target position using SDP in CVX<br/>
export_CDF_GM_SDP.m : Creates matrix sdpCDF.mat containing CDF for GM-SDP-2<br/>
export_CDF_WLS.m : Creates matrix wlsCDF.mat containing CDF for weighted least square (WLS)<br/>
export_crlb.m : Creates matrix crlb.mat containing Cramer-Rao Lower Bound (CRLB) for WSN Localization<br/>
export_GM_SDP.m : Creates matrix SDPrmse.mat containing RMSE for GM-SDP-2<br/>
export_WLS.m : Creates matrix SDPrmse.mat containing RMSE for WLS<br/>
findCrlb.m : Returns CRLB for a particular target and anchor placement <br/>
findRSS.m : Returns the Received Signal Strength (RSS) at all target nodes in a WSN<br/>
monteCarloInt.m : Returns the value of monte-carlo integration used in calculating the fisher information matrix<br/>
place.m : Used for setting the location of target and anchor nodes in WSN<br/>
plot_CDF.m : Used for plotting the CDF of various localization algorithms from their .mat files<br/>
plot_RMSE.m : Used for plotting the RMSE of various localization algorithms from their .mat files<br/>

Saved output folder contains .mat files of the variables plotted in the result screenshots section.

## Dependencies
```
CVX
Statistics and Machine Learning Toolbox
```

## Result Screenshots
![image1](https://github.com/kritiksoman/WSN-Localization/blob/master/results/WSN.png)<br/>
Example WSN.

![image2](https://github.com/kritiksoman/WSN-Localization/blob/master/results/PathLoss.png)<br/>
Path Loss Model.

![image3](https://github.com/kritiksoman/WSN-Localization/blob/master/results/RMSE.png)<br/> 
RMSE v/s N (number of anchors).

![image4](https://github.com/kritiksoman/WSN-Localization/blob/master/results/CDF.png)<br/>
CDF v/s error.

Note: Slightly different anchor placement was used in the WSN localization simulation.

## Steps to obtain results shown above
[1] Edit place.m for changing target and anchor node location.<br/>
[2] Run export_GM_SDP.m, export_WLS.m, and export_crlb.m to generate .mat files for RMSE.<br/>
[3] Run plot_RMSE.m to plot RMSE vs N.<br/>
[4] Run export_CDF_GM_SDP.m, and export_CDF_WLS.m to generate .mat files for CDF.<br/>
[5] Run plot_CDF.m to plot CDF vs error.<br/>

## References
[1] Zhang, Yueyue, et al. "RSS-based localization in WSNs using Gaussian mixture model via semidefinite relaxation." IEEE Communications Letters 21.6 (2017): 1329-1332.<br/>
[2] http://cvxr.com/cvx/
