# KAT
 KAT is a Matlab-based toolbox that implement an exact reconstruction algorithm for helical CT reconstruction.
 
 Most of the codes in the toolbox are vectorized and so the computations can be transfered from CPU and GPU. In the toolbox, we provide both the CPU and GPU implementations and the switching is controlled by setting the value of parameter 'usegpu' to be 0 or 1. We provide two examples here to demonstrate how to use our toolbox.
 
 # Example 1
 **##Exapmle 1: Reconstruct CT images from the data subset 'L109' of the '2016 NIH-AAPM-Mayo Clinic Low Dose CT Grand Challenge'.**
 
 Step 1: Download the dataset of the challenge from https://aapm.app.box.com/s/eaw4jddb53keg1bptavvvd1sf4x3pe9h.
 
 Step 2: Copy the 'L109' directory of the 'Training_Projection_Data' of the challenge dataset to our resposity folder and extract the compressed file 'DICOM-CT-PD_FD.zip' in the 'L109' folder. The file structure should looks like this:
<pre>
.           
├── example                                          # Example script
├── helical_curve                                    # Source files
├── images                                           # Some reconstructed images
├── L109                                             # Dataset folder
│   ├── DICOM-CT-PD_FD          
│   │   ├── L109_4M_100kv_fulldose1.00001.dcm   
│   │   ├── L109_4M_100kv_fulldose1.00002.dcm  
                             ...
│   │   ├── L109_4M_100kv_fulldose1.29226.dcm 
│   │   ├── L109_4M_100kv_fulldose1.txt    
├── LICENSE
└── README.md
</pre>
step 3: run the 'rec_L109.m' escript in the 'example' folder.

**Some reconstructed images looks like this:**

<img src="https://github.com/wangwei-cmd/KAT/blob/main/images/L109_1.png" width=30%> <img src="https://github.com/wangwei-cmd/KAT/blob/main/images/L109_20.png" width=30%> <img src="https://github.com/wangwei-cmd/KAT/blob/main/images/L109_128.png" width=30%>

# Example 2
**##Exapmle 2: Reconstruct CT images from the data subset 'dcm000' of the 'Truth-Based CT (TrueCT) Reconstruction Challenge'.**

Step 1: Download the dataset of the challenge (This may need contact the challenge organizer https://www.aapm.org/GrandChallenge/TrueCT/).
 
 Step 2: Copy the 'dcmproj_copd' directory of  the challenge dataset to our resposity folder. The file structure should looks like this:
<pre>
.           
├── example                                          # Example script
├── helical_curve                                    # Source files
├── images                                           # Some reconstructed images
├── dcmproj_copd                                     # Dataset folder
│   ├── dcm_000          
│   │   ├── mAs_vector_9000.bin
│   │   ├── proj_0001.dcm
│   │   ├── proj_0002.dcm
                 ...
│   │   ├── proj_9000.dcm   
├── LICENSE
└── README.md
</pre>
step 3: run the 'rec_dcm000.m' escript in the 'example' folder.

**Some reconstructed images looks like this:**

<img src="https://github.com/wangwei-cmd/KAT/blob/main/images/dcm000_1.png" width=30%> <img src="https://github.com/wangwei-cmd/KAT/blob/main/images/dcm000_100.png" width=30%> <img src="https://github.com/wangwei-cmd/KAT/blob/main/images/dcm000_350.png" width=30%>
