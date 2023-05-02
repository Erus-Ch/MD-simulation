#!/bin/bash

# this code adds a solid slab to the top of the structure


add_solid_to_top() {
file=$1
file_2_0=$2
gmx editconf -f ${file}.gro -c &> output.txt 2>1

x=$(grep "   center      : " output.txt | awk '{print $3}')
y=$(grep "   center      : " output.txt | awk '{print $4}')
z=$(grep "system size" output.txt | awk '{print $6}')
rm output.txt

wait 2
gmx editconf -f ${file_2_0}.gro -c &> output.txt 2>1
dz=$(grep "system size" output.txt | awk '{print $6}');

echo '#######################'
echo ${file_2_0}
echo  $x $y $z $dz

gmx editconf -f ${file_2_0}.gro -center $x $y $((z+dz)) -o ${file}_2.gro; 

awk 'NR>1{print t}{t=$0}' ${file}.gro > temp1
tail -n +3 ${file}_2.gro > temp2

cat temp1 temp2 > sys_new.gro

N1=$(awk 'NR==2{print $1}' sys_new.gro)   
N2=$(awk 'NR==2{print $1}' ${file_2_0}.gro)   
N=$((N1+N2))

sed -e "2s/.*$/${N}/g" sys_new.gro >new.gro

rm \#*
rm temp*
rm output.txt
mv new.gro sys_new.gro

gmx editconf -f sys_new.gro -c &> output.txt 2>1

x=$(grep "system size" output.txt | awk '{print $4}')
y=$(grep "system size" output.txt | awk '{print $5}')
z=$(grep "system size" output.txt | awk '{print $6}')

gmx editconf -f sys_new.gro -box $x $y $z -o sys_2.gro -c 
mv sys_2.gro sys_new.gro
rm output.txt
rm 1
rm out.gro 
rm \#*
rm ${file}_2.gro 
}



# call the function with two arguments
add_solid_to_top ${file} $solid

gmx editconf -f sys_new.gro -c &> output.txt 2>1

x=$(grep "system size" output.txt | awk '{print $4}')
y=$(grep "system size" output.txt | awk '{print $5}')
z=$(grep "system size" output.txt | awk '{print $6}')


gmx editconf -f sys_new.gro -rotate 0 180 0 -center $((x/2)) $((y/2)) $((z/2)) -o sys_new.gro -box $x $y $z 

maxz=$(awk 'BEGIN {max=0} {if ($6>max) max=$6} END {print max}' sys_new.gro)

gmx editconf -f sys_new.gro -translate 0 0 $((z-maxz)) -o sys_new.gro


add_solid_to_top "sys_new" $solid

gmx editconf -f sys_new.gro -c &> output.txt 2>1

x=$(grep "system size" output.txt | awk '{print $4}')
y=$(grep "system size" output.txt | awk '{print $5}')
z=$(grep "system size" output.txt | awk '{print $6}')

gmx editconf -f sys_new.gro -box $x $y 40 -center $((x/2)) $((y/2)) 20  -o sys_new.gro

 
rm temp* 
rm output.txt
rm 1
rm out.gro 
rm \#*
rm output.txt
pause 2
rm 1
rm out.gro 
