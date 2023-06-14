# KAT
 KAT is a Matlab-based toolbox that implement an exact reconstruction algorithm for helical CT reconstruction.
 
 Most of the codes in the toolbox are vectorized and so the computations can be transfered from CPU and GPU. In the toolbox, we provide both the CPU and GPU implementations and the switching is controlled by setting the value of parameter 'usegpu' to be 0 or 1. We provide two examples here to demonstrate how to use our toolbox.
 
 ##Exapmle 1: Reconstruct CT images from the data subset `L109' of the '2016 NIH-AAPM-Mayo Clinic Low Dose CT Grand Challenge'.
 
 Step 1:  &nbsp Download the dataset of the challenge from https://aapm.app.box.com/s/eaw4jddb53keg1bptavvvd1sf4x3pe9h.
 
 Step 2:  &nbsp Copy the `L109' directory of the 'Training_Projection_Data' of the challenge dataset to our resposity folder and extract the compressed file 'DICOM-CT-PD_FD.zip' in the `L109' folder. The file structure should looks like this:
<pre>
.
├── .git                
├── example                                          # example script
├── helical_curve                                    # Source files
├── L109                                             # dataset folder
│   ├── DICOM-CT-PD_FD          
│   │   ├── L109_4M_100kv_fulldose1.00001.dcm   
│   │   ├── L109_4M_100kv_fulldose1.00002.dcm  
                             ...
│   │   ├── L109_4M_100kv_fulldose1.29226.dcm 
│   │   ├── L109_4M_100kv_fulldose1.txt    
├── LICENSE
└── README.md
<pre>
 
