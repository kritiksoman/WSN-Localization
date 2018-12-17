# Node localization in Wireless Sensor Network

[![MIT](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/kritiksoman/Rooftop-Segmentation/blob/master/LICENSE)

## Overview
This is the MATLAB implementation of the work presented in [RSS-Based Localization in WSNs Using Gaussian Mixture Model via Semidefinite Relaxation](https://ieeexplore.ieee.org/abstract/document/7847378/).

'place.m' can be used to change the position of the target and anchor nodes.

'mainRSSLoc.m' finds the RMSE for different node placement configurations in WSN. 

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

## References
[1] Zhang, Yueyue, et al. "RSS-based localization in WSNs using Gaussian mixture model via semidefinite relaxation." IEEE Communications Letters 21.6 (2017): 1329-1332.

[2] http://cvxr.com/cvx/
