%FOTF Toolbox - A MATLAB Toolbox for the modeling, analysis and design of fractional-order systems
%
% (c) Professor Dingy\"u Xue, Northeastern University, Shenyang, China
%     Email: xuedingyu@mail.neu.edu.cn
%     Date of last modification, 23 December, 2016
%     
% This newly modified toolbox is written for the monograph, 
%
% @BOOK{bkXueDFOCS,    
%       Author = {Xue Dingy\"u},
%       Address = {Berlin},
%       Publisher = {de Gruyter Press},
%       Title = {Fractional-order Control Systems - Fundamentals and Numerical Implementations},
%       Year = {2017}
% }
%
% Multivariable fractional-order systems are fully supported in the classes FOTF and FOSS
% and low-level numerical algorithms are replaced by $O(h^p)$ precision ones. 
% For details in theory and programming, please refer to the monograph.

% (I) Special functions and fundamentals in numerical computation
%     beta_c  - beta function evaluation for complex arguments
%     common_order - compute the common order
%     fence_shadow - draw the shawdows on the walls
%     fmincon_global - a global constrained optimisation problem solver
%     funmsym - evaluate symbolic matrix functions
%     gamma_c - Gamma function evaluation for complex arguments
%     kronsum - compute Kronecker sum
%     mittag_leffler - symbolic evaluation of Mittag-Leffler functions
%     ml_func - numerical evaluation of Mittag-Leffler functions and derivatives
%     more_sols - find possible all solutions of nonlinear matrix equations
%     more_vpasols - symbolic version of more_sols, high precision solutions
%     new_inv - simple matrix inverse function, not recommended in applications 
%
%(II) Numerical evaluations of fractional-order derivatives and integrals
%     caputo   - computation of Caputo derivatives with interpolation, not recommended
%     caputo9  - evaluation of Caputo derivatives with $O(h^p)$, recommended
%     genfunc  - computation of generating function coefficients symbolically
%     get_vecw - computation of $O(h^p)$ weighting coefficients 
%     glfdiff0 - evaluation of GL derivatives, not recommended
%     glfdiff  - standard evaluation of GL derivatives, with $O(h)$
%     glfdiff2 - evaluation of $O(h^p)$ GL derivatives, not recommended      
%     glfdiff9 - evaluation of $O(h^p)$ GL derivatives, recommended       
%     glfdiff_fft - evaluation of $O(h^p)$ GL derivatives with FFT, not recommended
%     glfdiff_mat - matrix version of glfdiff, not recommended for large samples
%     glfdiff_mem - GL derivative evaluation with short-memory effect
%     rlfdiff  evaluation of RL derivatives, not recommended, use glfdiff9 instead
%
%(III) Numerical evaluations of linear fractional-order differential equations
%     caputo_ics   - equivalent initial condition reconstruction, called by fode_caputo9
%     fode_caputo0 - simple Caputo FODE solver with nonzero initial conditions
%     fode_caputo9 - $O(h^p)$ solution of Caputo equations with nonzero ICs
%     fode_sol - closed-form solution of FODE with zero initial conditions
%     fode_solm - matrix version of fode_sol, not recommended for large samples
%     fode_sol9 - $O(h^p)$ version of fode_sol
%     ml_step3 - numerical solution of step response of 3-term models
%
%(IV) Numerical evaluations of nonlinear fractional-order differential equations
%     INVLAP_new - closed-loop response evaluation with inverse Laplace transform
%     nlfode_mat - matrix-based solutions of implicit nonlinear FODEs 
%     nlfode_vec - nonlinear fractional-order extended state space equation solver 
%     nlfode_vec1 - a different version of nlfode_vec, not recommended
%     nlfec - $O(h^p)$ corrector solution of nonlinear multi-term FODEs
%     nlfep - $O(h^p)$ predictor solution of nonlinear multi-term fractional-order ODEs
%     pepc_nlfode - numerical solutions of single-term nonlinear FODE with PCPE algorithm
%
%(V) Filter design for fractional-order derivatives and systems
%     carlson_fod - design of a Carlson filter
%     charef_fod - design of a Charef filter
%     charef_opt - design of an optimal Charef filter
%     cont_frac0 - continued-fraction interface to irrational functions
%     matsuda_fod - design of Matsuda-Fujii filter 
%     new_fod - design of a modified Oustaloup filter
%     opt_app - optimal IO transfer approximation of high-order models
%     ousta_fod   - design of a standard Oustaloup filter
%
%(VI) FOTF object design and overload functions
%     base_order - find the base order from an FOTF object
%     bode - Bode diagram analysis
%     diag - diagonal FOTF matrix creation and extraction
%     display - overload function to display a MIMO FOTF object
%     eig - find all the poles, including extraneous roots
%     eq - checks whether two FOTF blocks equal or not
%     feedback - overload the feedback function for two FOTF blocks
%     foss_a   - convert an FOTF to an extended FOSS object
%     fotf - creation of an FOTF class
%     fotf2cotf  - convert an FOTF object into commensurate form
%     fotf2foss  - low-level conversion function of FOTF to FOSS object
%     fotfdata  - extract all the fields from an FOTF object
%     freqresp   - low-level frequency response function of an FOTF object
%     high_order - high-order IO transfer function approximation of FOTF objects
%     impulse - evaluation of impulse response of an FOTF object 
%     inv - inverse FOTF matrix
%     isstable - check whether an FOTF object stable or not
%     iszero - check whether an FOTF object is zero or not  
%     lsim   - time response evaluation to arbitrary input signals
%     margin - compute the gain and phase margins 
%     maxdelay - extract maximum delay from an FOTF object
%     mfrd - frequency response evaluation
%     minus  - minus operation of two FOTF objects
%     mldivide - left-division function
%     mpower   - power of an FOTF object
%     mrdivide - right-division function
%     mtimes  - overload function of * operation of two blocks
%     nichols - Nichols chart
%     norm - H2 and Hinf evaluation 
%     nyquist - Nyquist plot
%     plus    - overload function of + operation of two blocks
%     residue - partial fraction expansion
%     rlocus  - root locus analysis
%     sigma   - singular value plots
%     simplify - simplification of an FOTF object
%     step - step response
%     uminus - unary minus of an FOTF object
%
%(VII) FOSS object design and overload functions
%     bode - Bode diagram analysis
%     coss_aug - FOSS augmentation
%     ctrb  - controllability test matrix creation
%     display - overload function to display a MIMO FOSS object
%     eig - compute the poles of a FOSS object 
%     eq - checks two FOSS blocks equal or not
%     feedback - overload the feedback function for two FOSS blocks
%     foss - FOSS class creation
%     foss2fotf - low-level conversion from FOSS to FOTF object
%     impulse - evaluation of impulse response of an FOSS object 
%     inv - inverse of an FOSS object
%     isstable - check an FOSS object stable or not
%     lsim   - time response evaluation to arbitrary input signals
%     margin - compute the gain and phase margins 
%     mfrd - frequency response evaluation
%     minreal - minimum realisation of a FOSS object
%     minus  - minus operation of two FOTF objects
%     mpower   - power of an FOSS object
%     mtimes  - overload function of * operation of two blocks
%     nichols - Nichols chart
%     norm - H2 and Hinf evaluation 
%     nyquist - Nyquist plot
%     obsv  - construct observability test matrix
%     order - find the orders of an FOSS object
%     plus    - overload function of + operation of two blocks
%     rlocus  - root locus analysis
%     size - find the numbers of inputs, outputs and states
%     ss_extract - extract integer-order state space object from FOSS
%     step - step response
%     uminus - unary minus of an FOSS object
%
%(VIII) Simulink models
%     fotflib - Simulink blockset for FOTF Toolbox
%     fotf2sl - multivariable FOTF to Simulink block convertor
%     sfun_mls - S-function version of Mittag-Leffler function
%     slblocks - default Simulink description file 
%     c9mvofuz - Simulink model for variable-order fuzzy PID control systems
%     c9mvofuz2 - Simulink model for variable-order fuzzy PID systems with variable delays
%     c10mpdm2 - Simulink model for multivariable PID control system
%     c10mpopt - Simulink model for multivariable parameter optimisation control systems
%     fPID_simu - Simulink model fractional-order PID controller for single-variable system
%
%(IX) Fractional-order and other controller design
%     c9mfpid - fractional-order PID controller design with equation solution techniques
%     c9mfpid_con - constraints in optimum FOPID design of FOPDT plants 
%     c9mfpid_con1 - constraints in optimum FOPID design of FOIPDT plants
%     c9mfpid_con2 - constraints in optimum FOPID design of FO-FOPDT plants
%     c9mfpid_opt - objective function in optimum FOPID design of FOPDT plants
%     c9mfpid_opt1 - objective function in optimum FOPID design of FOIPDT plants
%     c9mfpid_opt2 - objective function in optimum FOPID design of FO-FOPDT plants
%     ffuz_param - S-function for parameter setting of fuzzy fractional-order PIDs
%     fopid - construct a \fPID{} controller from parameters
%     fpidfun - an example of objective function for optimum fractional-order PIDs
%     fpidfuns - objective function for fractional-order PID controller design
%     fpidtune - design of optimum fractional-order PID controllers
%     gershgorin - draw Nyquist plots with Gershgorin bands
%     get_fpidf - build string expression of the open-loop model
%     mfd2frd - convert MFD data into FRD data 
%     optimfopid - GUI for optimum fractional-order PID design
%     optimpid - GUI for optimum integer-order PID design 
%     pseuduag - pseudodiagonalisation of multivariable systems
%
%(X) Dedicated functions and models for the examples
%     c2exnls - constraint function of an example 
%     c8mstep - Simulink model of a multivariable fractional-order system
%     c8mfpid1 - Simulink model of a fractional-order PID control system
%     c8mchaos - vectorised Simulink model for fractional-order Chua system
%     c8mchaosd - data input file for c8mchaos
%     c8mchua - MATLAB description of fractional-order Chua equations
%     c8mchuasim - Simulink model for fractional-order Chua circuit
%     c8mblk2,3,5 - three Simulink models of a linear fractional-order equation
%     c8mcaputo - complicated Simulink model for nonlinear FODE 
%     c8mexp2 - simpler Simulink model for nonlinear Caputo equations
%     c8mexp2m - MATLAB description of nonlinear Caputo equation
%     c8mnlf1, c8mnlf2 - two different Simulink models of a nonlinear FODE 
%     c8mexp1x - MATLAB function for describing nonlinear Caputo equations
%     c8nleq - MATLAB description of a nonlinear single-term Caputo equation
%     c8mlinc1 - Simulink model of a linear fractional-order Caputo equation
%     c9ef1-c9ef3 - criteria for optimum fractional-order PID controllers
%     c9mplant - Simulink model used for optimpid design

