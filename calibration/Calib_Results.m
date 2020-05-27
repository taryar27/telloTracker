% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 910.754860998684080 ; 916.126218633263875 ];

%-- Principal point:
cc = [ 472.550961031335191 ; 368.635463733376866 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.013975480365793 ; 0.002500024419527 ; 0.014511701591424 ; -0.001943718628812 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 12.082008902059373 ; 11.655355867633634 ];

%-- Pixel error:          
err = [ 0.57984 ; 0.76695 ];

%-- Principal point uncertainty:
cc_error = [ 9.316576377026866 ; 9.477081977655699 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.029015606575749 ; 0.097173833027757 ; 0.003045445234779 ; 0.003479903246863 ; 0.000000000000000 ];

%-- Image size:
nx = 960;
ny = 720;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 10;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.184226e+00 ; 2.170659e+00 ; -1.670974e-01 ];
Tc_1  = [ -8.519815e+01 ; -1.340600e+02 ; 5.358745e+02 ];
omc_error_1 = [ 1.169815e-02 ; 1.333249e-02 ; 2.625834e-02 ];
Tc_error_1  = [ 5.581034e+00 ; 5.534438e+00 ; 7.494711e+00 ];

%-- Image #2:
omc_2 = [ 2.088529e+00 ; 1.960290e+00 ; 8.852632e-02 ];
Tc_2  = [ -8.767986e+01 ; -8.760238e+01 ; 5.041142e+02 ];
omc_error_2 = [ 1.143629e-02 ; 1.110701e-02 ; 2.024772e-02 ];
Tc_error_2  = [ 5.192616e+00 ; 5.216947e+00 ; 7.084429e+00 ];

%-- Image #3:
omc_3 = [ -2.191732e+00 ; -2.141137e+00 ; -1.034373e-01 ];
Tc_3  = [ -1.694412e+02 ; -9.172304e+01 ; 5.828283e+02 ];
omc_error_3 = [ 1.632689e-02 ; 1.441937e-02 ; 3.563941e-02 ];
Tc_error_3  = [ 6.002690e+00 ; 6.137628e+00 ; 8.583159e+00 ];

%-- Image #4:
omc_4 = [ -1.961935e+00 ; -2.108623e+00 ; 4.083931e-01 ];
Tc_4  = [ -6.379146e+01 ; -9.582710e+01 ; 5.872636e+02 ];
omc_error_4 = [ 1.069917e-02 ; 1.068929e-02 ; 2.296668e-02 ];
Tc_error_4  = [ 6.061958e+00 ; 6.056441e+00 ; 7.595933e+00 ];

%-- Image #5:
omc_5 = [ 2.239473e+00 ; 2.150339e+00 ; -2.585289e-01 ];
Tc_5  = [ -7.618369e+01 ; -5.833557e+01 ; 3.536845e+02 ];
omc_error_5 = [ 8.181385e-03 ; 7.792975e-03 ; 1.808339e-02 ];
Tc_error_5  = [ 3.628143e+00 ; 3.637953e+00 ; 4.762134e+00 ];

%-- Image #6:
omc_6 = [ 1.984996e+00 ; 1.632989e+00 ; 3.304469e-01 ];
Tc_6  = [ -1.816674e+02 ; -6.993767e+01 ; 3.697945e+02 ];
omc_error_6 = [ 9.895223e-03 ; 9.404986e-03 ; 1.463512e-02 ];
Tc_error_6  = [ 3.916825e+00 ; 3.997654e+00 ; 5.822847e+00 ];

%-- Image #7:
omc_7 = [ 2.255221e+00 ; 2.138604e+00 ; 6.665434e-02 ];
Tc_7  = [ -1.145398e+02 ; -8.044107e+01 ; 3.585649e+02 ];
omc_error_7 = [ 9.033272e-03 ; 8.721407e-03 ; 1.968362e-02 ];
Tc_error_7  = [ 3.726424e+00 ; 3.778737e+00 ; 5.124748e+00 ];

%-- Image #8:
omc_8 = [ -1.861175e+00 ; -2.108953e+00 ; 5.325311e-01 ];
Tc_8  = [ -4.142698e+01 ; -7.474815e+01 ; 3.929357e+02 ];
omc_error_8 = [ 7.830414e-03 ; 7.660585e-03 ; 1.577881e-02 ];
Tc_error_8  = [ 4.030826e+00 ; 4.008999e+00 ; 4.890803e+00 ];

%-- Image #9:
omc_9 = [ 1.904965e+00 ; 1.900697e+00 ; -6.146875e-01 ];
Tc_9  = [ -7.947703e+01 ; -8.850394e+01 ; 3.744459e+02 ];
omc_error_9 = [ 7.259992e-03 ; 9.842407e-03 ; 1.479266e-02 ];
Tc_error_9  = [ 3.882096e+00 ; 3.854736e+00 ; 4.720932e+00 ];

%-- Image #10:
omc_10 = [ -1.927538e+00 ; -2.123975e+00 ; 2.811562e-01 ];
Tc_10  = [ -8.694242e+01 ; -9.675592e+01 ; 3.421935e+02 ];
omc_error_10 = [ 7.455077e-03 ; 7.129337e-03 ; 1.607726e-02 ];
Tc_error_10  = [ 3.548143e+00 ; 3.538009e+00 ; 4.660886e+00 ];

