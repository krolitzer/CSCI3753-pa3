#!/bin/bash
#Script to generate all the data 
#need to be admin
LIGHT=5
MEDIUM=60
HEAVY=160

make clean 
make
#-------------------OTHER IO LIGHT --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Light_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Light_IO -a  ./rw $LIGHT SCHED_OTHER
done
echo "1 done"
#---------------OTHER CPU LIGHT -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Light_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Light_CPU -a  ./pi-sched $LIGHT SCHED_OTHER
done
echo "2 done"
#--------------OTHER MIXED LIGHT ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Light_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Light_MIXED -a  ./mixed $LIGHT SCHED_OTHER
done
echo "3 done"
#-------------------OTHER IO MEDIUM --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Medium_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Medium_IO -a  ./rw $MEDIUM SCHED_OTHER
done
echo "4 done"
#---------------OTHER CPU MEDIUM -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Medium_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Medium_CPU -a  ./pi-sched $MEDIUM SCHED_OTHER
done
echo "5 done"
#--------------OTHER MIXED MEDIUM ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Medium_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Medium_MIXED -a  ./mixed $MEDIUM SCHED_OTHER
done
echo "6 done"
#-------------------OTHER IO HEAVY --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Heavy_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Heavy_IO -a  ./rw $HEAVY SCHED_OTHER
done
echo "7 done"
#---------------OTHER CPU HEAVY -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Heavy_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Heavy_CPU -a  ./pi-sched $HEAVY SCHED_OTHER
done
echo "8 done"
#--------------OTHER MIXED HEAVY ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_OTHER_Heavy_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_OTHER_Heavy_MIXED -a  ./mixed $HEAVY SCHED_OTHER
done
echo "9 done"
#-------------------RR IO LIGHT --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Light_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Light_IO -a  ./rw $LIGHT SCHED_RR
done
echo "10 done"
#---------------RR CPU LIGHT -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Light_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Light_CPU -a  ./pi-sched $LIGHT SCHED_RR
done
echo "11 done"
#--------------RR MIXED LIGHT ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Light_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Light_MIXED -a  ./mixed $LIGHT SCHED_RR
done
echo "12 done"
#-------------------RR IO MEDIUM --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Medium_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Medium_IO -a  ./rw $MEDIUM SCHED_RR
done
echo "13 done"
#---------------RR CPU MEDIUM -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Medium_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Medium_CPU -a  ./pi-sched $MEDIUM SCHED_RR
done
echo "14 done"
#--------------RR MIXED MEDIUM ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Medium_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Medium_MIXED -a  ./mixed $MEDIUM SCHED_RR
done
echo "15 done"
#-------------------RR IO HEAVY --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Heavy_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Heavy_IO -a  ./rw $HEAVY SCHED_RR
done
echo "16 done"
#---------------RR CPU HEAVY -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Heavy_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Heavy_CPU -a  ./pi-sched $HEAVY SCHED_RR
done
echo "17 done"
#--------------RR MIXED HEAVY ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_RR_Heavy_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_RR_Heavy_MIXED -a  ./mixed $HEAVY SCHED_RR
done
echo "18 done"
#-------------------FIFO IO LIGHT --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Light_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Light_IO -a  ./rw $LIGHT SCHED_FIFO
done
echo "19 done"
#---------------FIFO CPU LIGHT -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Light_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Light_CPU -a  ./pi-sched $LIGHT SCHED_FIFO
done
echo "20 done"
#--------------FIFO MIXED LIGHT ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Light_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Light_MIXED -a  ./mixed $LIGHT SCHED_FIFO
done
echo "21 done"
#-------------------FIFO IO MEDIUM --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Medium_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Medium_IO -a  ./rw $MEDIUM SCHED_FIFO
done
echo "22 done"
#---------------FIFO CPU MEDIUM -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Medium_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Medium_CPU -a  ./pi-sched $MEDIUM SCHED_FIFO
done
echo "23 done"
#--------------FIFO MIXED MEDIUM ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Medium_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Medium_MIXED -a  ./mixed $MEDIUM SCHED_FIFO
done
echo "24 done"
#-------------------FIFO IO HEAVY --------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Heavy_IO
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Heavy_IO -a  ./rw $HEAVY SCHED_FIFO
done
echo "25 done"
#---------------FIFO CPU HEAVY -----------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Heavy_CPU
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Heavy_CPU -a  ./pi-sched $HEAVY SCHED_FIFO
done
echo "26 done"
#--------------FIFO MIXED HEAVY ---------------------------------

echo "%Real Time (s), Time spent in Kernel Mode (s), Time spent in user mode, Percentage of the CPU gotten, Involuntarily Contex switches, Voluntarily context switchs " > data_FIFO_Heavy_MIXED
for i in 1 2 3
do
/usr/bin/time --format="%e,%S,%U,%P,%c,%w" -o data_FIFO_Heavy_MIXED -a  ./mixed $HEAVY SCHED_FIFO
done
echo "27 done"
#------------------------DATA MOVING--------------------------
mv data_* bfs
