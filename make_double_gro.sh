#!/bin/bash
#file=bilayer

gmx editconf -f ${file}.gro -rotate 0 180 0 -o ${file}_2_0.gro

gmx editconf -f ${file}.gro -c &> output.txt 2>1

x=$(grep "   center      : " output.txt | awk '{print $3}')
y=$(grep "   center      : " output.txt | awk '{print $4}')
z=$(grep "   center      : " output.txt | awk '{print $5}')
dz=$(grep "box vectors" output.txt | awk '{print $6}')

pause 2
gmx editconf -f ${file}_2_0.gro -center $x $y $((z+dz+0.1)) -o ${file}_2.gro 

pause 2
awk 'NR>1{print t}{t=$0}' ${file}.gro > temp1
tail -n +3 ${file}_2.gro > temp2

cat temp1 temp2 > sys.gro

N=$(awk 'NR==2{print $1*2}' sys.gro)   

sed -e "2s/.*$/${N}/g" sys.gro >new.gro

rm \#
rm temp*
rm output.txt
mv new.gro sys.gro

gmx editconf -f sys.gro -c &> output.txt 2>1

x=$(grep "box vectors :" output.txt | awk '{print $4}')
y=$(grep "box vectors :" output.txt | awk '{print $5}')
z=$(grep "system size" output.txt | awk '{print $6}')

gmx editconf -f sys.gro -box $x $y $z -o sys_2.gro 
mv sys_2.gro ${file}_double.gro

rm ${file}_2.gro ${file}_2_0.gro
rm sys.gro
rm sys_2.gro
rm output.txt
rm 1
rm out.gro 
rm \#*
