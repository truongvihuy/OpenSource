#! /bin/bash

#Tao ham
randomNumber()
{
	let run=RANDOM+1
	while [ $run -gt $1 ];do
		let run=RANDOM+1
	done
	echo $run
}

clear
echo "Vui long chon chuc nang"
echo "<1> Them cau hoi - Tich hop them cau tra loi"
echo "<2> Xuat de trac nghiem"
echo "<3> Thoat chuong trinh"

read -p "Chon cong viec thuc hien: " choose
case $choose in
	1) 	#Them cau hoi - tich hop cau tra loi
		clear
		echo "=== THEM CAU HOI VA CAU TRA LOI ==="
		#Tao bien luu tru cau hoi va lua chon nhap vao
		read -p "Nhap cau hoi can them: " question
		read -p "Lua chon a: " a
		read -p "Lua chon b: " b
		read -p "Lua chon c: " c
		read -p "Lua chon d: " d
		read -p "Dap an: " answer
		#Tao bien luu tru thong tin ghi vao file
		content=$question-$a-$b-$c-$d
		echo $content >> Cauhoi.txt
		echo $answer >> Traloi.txt
	;;

	2) 	#Xuat de trac nghiem
		if [ -f Cauhoi.txt ];then
			# Xoa de thi cu
			if [ -f DeTracNghiem.txt ];then
				rm -f DeTracNghiem.txt
			fi
			#Doc de dem so dong de biet so cau hoi trong file Cauhoi.txt
			count=0
			while read line;do
				let count=$count+1
			done < Cauhoi.txt	
			######
			clear
			read -p "Nhap so luong cau trac nghiem can xuat: " num
			echo ""
			echo "=== DE TRAC NGHIEM NGAU NHIEN - SO CAU $num ==="
			#Chon cau hoi ngau nhien va in ra de trac nghiem 
			i=1
			dung=0
			while [ $i -le $num ];do  
				#Lay gia tri dong ngau nhien trong file Cauhoi.txt
				randomchoice=$(randomNumber $count)
				#Khoi tao bien dem dong
				numline=1
				#Lay cau hoi theo randomchoice
				while read line;do
					#Neu so dong thu numline trong Cauhoi.txt = randomchoice
					if [ $numline -eq $randomchoice ];then
						#Ghi noi dung cau hoi va lua chon vao mang
						for k in {1..5};do
							questionarr[k]=$(echo $line | cut -f$k -d"-")
						done
						#In cau hoi
						echo "Cau hoi $i: ${questionarr[1]}"
						echo "1:${questionarr[2]}" 
						echo "2:${questionarr[3]}" 
						echo "3:${questionarr[4]}" 
						echo "4:${questionarr[5]}"
						##break
					fi
					#Tang bien dem so dong trong Cauhoi.txt
					let numline=$numline+1
				done < Cauhoi.txt
				read -p "Dap an: " answer
				#Xuat dap an
				numline=1
				while read line;do
					if [ $numline -eq $randomchoice ];then
						if [ $line -eq $answer ];then
							let dung=$dung+1
							echo "Dung"
						else
							echo "Sai - $line"
						fi
						echo ""
					fi
					let numline=$numline+1
				done < Traloi.txt
				#Luu cac dong cau hoi da in ra vao DeTracNghiem.txt
				echo $randomchoice >> DeTracNghiem.txt
				#Tang bien dem so cau da ghi
				let i=$i+1
			done
			echo "So cau dung: $dung/$num"
		else
			echo "Tap tin Cauhoi.txt khong ton tai"
		fi
	;;

	3)	#Thoat
		exit 0
	;;

	*)	#Truong hop khac
		bash project.sh
	;;
esac
