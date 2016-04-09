while read p; do
	echo $p | base64 --decode
	echo 
done < Apache.log