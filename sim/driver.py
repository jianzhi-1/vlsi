import os
fp1="./script.sp"
fp2="./script_runner.sp" # temporary file
mea="./script_runner.measure" # measurement file
res="./res.txt" # collated results
t_arr = range(50, 500, 50) # range of d rise time to sweep
for t in t_arr:
   with open(fp1, "r") as f1, open(fp2, "w") as f2:
       for line in f1:
           if "vpwl" in line.strip().split():
               f2.write("vpwl d 0 PWL(0 0 {}p 0 {}p 1.8)\n".format(t, t+10))
           else:
               f2.write(line)
   os.system("spectre ./script_runner.sp")
   with open(mea, "r") as f1, open(res, "a") as f2:
       for line in f1:
           if "tplh" in line:
               arr = line.strip().split()
               f2.write("{}p to {}p -> {}\n".format(t, t+10, arr[2]))
