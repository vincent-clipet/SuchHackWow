
# contient les données du fichier .bin
data = []

# Chargement du fichier dans data[]
File.open("ch7.bin") do |f|
  while byte = f.read(1)
	data << byte
  end
end

# contient la chaîne, shiftée
out = []

# On ne connait pas la valeur du décalage, donc on bruteforce entre -;)
(0..255).each do | bruteforce |
	tmpArray = []
	
	# parcours du fichier .bin
	data.each do | char |
		# 'char.ord()' donne le code ascii décimal
		# '(...).chr() donne le char correspondant au code ascii décimal'
		tmpArray << ((char.ord() - bruteforce) % 256).chr()
	end
	
	# ajoute la chaine shiftée aux résultats
	out << tmpArray.join.to_s
end

# affiche les chaines shiftées
out.each do | elem |
	puts elem
end