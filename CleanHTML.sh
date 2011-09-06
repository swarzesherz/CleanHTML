#!/bin/bash
#Definimos dierectorio de trabajo
WORKPATH=`dirname "$0"`
clear
#Definimos variable para limpiar los archivos de etiquetas <font>
FONT="false"
while false; do
	echo
	read -p "Desea limpiar las etiquetas <font> de algun archivo? " yn
		case $yn in
		si)
			FONT="true"
			break;;
		no)
			FONT="false"
			break;;
		*) echo "Por favor responda si o no";;
	esac
done
echo "Buscando archivos html dentro de la carpeta body"
clear
#Entramos al directorio de trabajo a buscar los archivosS
cd "$WORKPATH"
for i in $(find ./ | egrep "\/body\/(.*)\.htm$"); do
	FILE_DIR=`dirname "$i"`
	FIME_NAME=`echo $i | sed "s:$FILE_DIR\/::g"`
	echo "Limpiando contenido del archivo $FIME_NAME"
#Verificando codificaci�n del arhivo
if file -i $i | egrep "charset=utf\-8" > /dev/null; then
	tidy -config /etc/tidyUTF8 -m "$i"
else
	tidy -config /etc/tidy -m "$i"
fi	
#Quitando saltos de l�nea
#	cat $i | xargs echo > ${i}.bak
	sed ':a;N;$!ba;s/\n//g' $i > ${i}.bak
#Limpiando HTML
	cat ${i}.bak | \
	sed -e 's:\ >:>:g' \
	-e 's:</\?[A-Z][A-Z0-9]*[^<>]*>:\L&:g' \
	-e 's:<!DOCTYPE[^>]*>::g' \
	-e 's:<html[^>]*>:<html>:g' \
	-e 's:<body[^>]*>:<body>:g' \
	-e 's:<!--.*\?-->::g' \
	-e 's:<meta[^>]*>::g' \
	-e 's:<style[^>]*>\(.*\?\)<\/style>::g' \
	-e 's:<script[^>]*>\(.*\?\)<\/script>::g' \
	-e 's:<script[^>]*\/>::g' \
	-e 's:<link[^>]*>::g' \
	-e 's:class=\"[^\"]*\"::g' \
	-e 's:style=\"[^\"]*\"::g' \
	-e 's:</\?h[0-9][^>]*>::g' \
	-e 's:</\?dir[^>]*>::g' \
	-e 's:</\?o\:p[^>]*>::g' \
	-e 's:</\?span[^>]*>::g' \
	-e 's:</\?div[^>]*>::g' \
	-e 's:<div[^>]*>:<p>:g' \
	-e 's:<\/div>:<\/p>:g' \
	-e 's:^<div><\/div>$:<p>\&nbsp;<\/p>:g' \
	-e 's:<p><\/p>:<p>\&nbsp;<\/p>:g' \
	-e 's:<p>:<p align=\"justify\">:g' \
	-e 's:</\?td[^>]*>::g' \
	-e 's:</\?th[^>]*>::g' \
	-e 's:</\?tr[^>]*>::g' \
	-e 's:</\?table[^>]*>::g' \
	-e 's:<strong[^>]*>:<b>:g' \
	-e 's:<\/strong>:<\/b>:g' \
	-e 's:<em[^>]*>:<i>:g' \
	-e 's:<\/em>:<\/i>:g' \
	-e 's:\[:\&#91;:g' \
	-e 's:\]:\&#93;:g' \
	-e 's:\(\&ndash;\|�\):\&#150;:g' \
	-e 's:\(\&mdash;\|�\):\&#151;:g' \
	-e "s:\(�\|�\):':g" \
	-e 's:\(\&ldquo;\|\&rdquo;\|\&quot;\|�\|�\):":g' \
	-e 's:\\ &\ :\\ &amp;\ :g' \
	-e 's:�:\&#181;:g' \
	-e 's:�:\&ordf;:g' \
	-e 's:�:\&ordm;:g' \
	-e 's:\�:\&aacute;:g' \
	-e 's:\�:\&eacute;:g' \
	-e 's:\�:\&iacute;:g' \
	-e 's:\�:\&oacute;:g' \
	-e 's:\�:\&uacute;:g' \
	-e 's:\�:\&Aacute;:g' \
	-e 's:\�:\&Eacute;:g' \
	-e 's:\�:\&Iacute;:g' \
	-e 's:\�:\&Oacute;:g' \
	-e 's:\�:\&Uacute;:g' \
	-e 's:\�:\&acirc;:g' \
	-e 's:\�:\&ecirc;:g' \
	-e 's:\�:\&icirc;:g' \
	-e 's:\�:\&ocirc;:g' \
	-e 's:\�:\&ucirc;:g' \
	-e 's:\�:\&Acirc;:g' \
	-e 's:\�:\&Ecirc;:g' \
	-e 's:\�:\&Icirc;:g' \
	-e 's:\�:\&Ocirc;:g' \
	-e 's:\�:\&Ucirc;:g' \
	-e 's:\�:\&agrave;:g' \
	-e 's:\�:\&egrave;:g' \
	-e 's:\�:\&igrave;:g' \
	-e 's:\�:\&ograve;:g' \
	-e 's:\�:\&ugrave;:g' \
	-e 's:\�:\&Agrave;:g' \
	-e 's:\�:\&Egrave;:g' \
	-e 's:\�:\&Igrave;:g' \
	-e 's:\�:\&Ograve;:g' \
	-e 's:\�:\&Ugrave;:g' \
	-e 's:\�:\&auml;:g' \
	-e 's:\�:\&euml;:g' \
	-e 's:\�:\&iuml;:g' \
	-e 's:\�:\&ouml;:g' \
	-e 's:\�:\&uuml;:g' \
	-e 's:\�:\&Auml;:g' \
	-e 's:\�:\&Euml;:g' \
	-e 's:\�:\&Iuml;:g' \
	-e 's:\�:\&Ouml;:g' \
	-e 's:\�:\&Uuml;:g' \
	-e 's:\�:\&atilde;:g' \
	-e 's:\�:\&otilde;:g' \
	-e 's:\�:\&Atilde;:g' \
	-e 's:\�:\&Otilde;:g' \
	-e 's:\�:\&ntilde;:g' \
	-e 's:\�:\&Ntilde;:g' \
	-e 's:\�:ae:g' \
	-e 's:\�:AE:g' \
	-e 's:\�:OE:g' \
	-e 's:\�:oe:g' \
	-e 's:\�:S:g' \
	-e 's:\�:s:g' \
	-e 's:\�:Y:g' \
	-e 's:\�:y:g' \
	-e 's:\�:\&#946;:g' \
	-e 's:\&#64258;:fl:g' \
	-e 's:\&#64257;:fi:g' \
	-e '/^$/d' > $i
	rm -rf ${i}.bak
#Limpiar etiquetas <font> inecesarias de acuerdo a la condici�n inicial
	while $FONT; do
		echo
		read -p "Desea limpiar las etiquetas <font> del archivo \"$FIME_NAME\", al aceptar eliminara todas las etiquetas <font> del HTML: " yn
			case $yn in
			si)
				sed -e 's:</\?font[^<>]*>::g' $i > ${i}.bak
				mv ${i}.bak $i
				break;;
			no)
				break;;
			*) echo "Por favor responda si o no";;
		esac
	done
#Por omisi�n limpiamos las etiquetas <font> basura 
	sed -e 's:</\?font[^<>]*>::g' $i > ${i}.bak
	mv ${i}.bak $i
#Identando condigo HTML
	tidy -config /etc/tidy -m -i "$i"
#Reemplazamos etiquetas que usa tidy
	sed -e 's:\[:\&#91;:g' \
	-e 's:\]:\&#93;:g' \
	-e 's:\(\&ndash;\|�\):\&#150;:g' \
	-e 's:\(-\):\&#45;:g' \
	-e 's:\(\&mdash;\|�\):\&#151;:g' \
	-e 's:�:\&#181;:g' \
	-e 's:\�:\&#946;:g' \
	-e 's:</\?blockquote[^>]*>::g' \
	-e 's:\ \ \ \ :\t:g' \
	-e 's:\&Alpha;:\&#913;:g' \
	-e 's:\&Beta;:\&#914;:g' \
	-e 's:\&Gamma;:\&#915;:g' \
	-e 's:\&Delta;:\&#916;:g' \
	-e 's:\&Epsilon;:\&#917;:g' \
	-e 's:\&Zeta;:\&#918;:g' \
	-e 's:\&Eta;:\&#919;:g' \
	-e 's:\&Theta;:\&#920;:g' \
	-e 's:\&Iota;:\&#921;:g' \
	-e 's:\&Kappa;:\&#922;:g' \
	-e 's:\&Lambda;:\&#923;:g' \
	-e 's:\&Mu;:\&#924;:g' \
	-e 's:\&Nu;:\&#925;:g' \
	-e 's:\&Xi;:\&#926;:g' \
	-e 's:\&Omicron;:\&#927;:g' \
	-e 's:\&Pi;:\&#928;:g' \
	-e 's:\&Rho;:\&#929;:g' \
	-e 's:\&Sigma;:\&#931;:g' \
	-e 's:\&Tau;:\&#932;:g' \
	-e 's:\&Upsilon;:\&#933;:g' \
	-e 's:\&Phi;:\&#934;:g' \
	-e 's:\&Chi;:\&#935;:g' \
	-e 's:\&Psi;:\&#936;:g' \
	-e 's:\&Omega;:\&#937;:g' \
	-e 's:\&alpha;:\&#945;:g' \
	-e 's:\&beta;:\&#946;:g' \
	-e 's:\&gamma;:\&#947;:g' \
	-e 's:\&delta;:\&#948;:g' \
	-e 's:\&epsilon;:\&#949;:g' \
	-e 's:\&zeta;:\&#950;:g' \
	-e 's:\&eta;:\&#951;:g' \
	-e 's:\&theta;:\&#952;:g' \
	-e 's:\&iota;:\&#953;:g' \
	-e 's:\&kappa;:\&#954;:g' \
	-e 's:\&lambda;:\&#955;:g' \
	-e 's:\&mu;:\&#956;:g' \
	-e 's:\&nu;:\&#957;:g' \
	-e 's:\&xi;:\&#958;:g' \
	-e 's:\&omicron;:\&#959;:g' \
	-e 's:\&pi;:\&#960;:g' \
	-e 's:\&rho;:\&#961;:g' \
	-e 's:\&sigmaf;:\&#962;:g' \
	-e 's:\&sigma;:\&#963;:g' \
	-e 's:\&tau;:\&#964;:g' \
	-e 's:\&upsilon;:\&#965;:g' \
	-e 's:\&phi;:\&#966;:g' \
	-e 's:\&chi;:\&#967;:g' \
	-e 's:\&psi;:\&#968;:g' \
	-e 's:\&omega;:\&#969;:g' \
	-e 's:\&thetasym;:\&#977;:g' \
	-e 's:\&upsih;:\&#978;:g' \
	-e 's:\&piv;:\&#982;:g' \
	$i > ${i}.bak
	mv ${i}.bak $i
#Por omision agregamos las etiquetas <font> estandar
	sed -e 's:<p>:<p align=\"justify\">:g' -e 's:<p[^>]*>:&<font face=\"verdana\" size=\"2\">:g' -e 's:<\/p>:<\/font><\/p>:g' $i > ${i}.bak
	mv ${i}.bak $i
#Limpiando pantalla
#	clear
done
echo "Limpieza de codigo HTML completa"