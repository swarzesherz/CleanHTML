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
for i in $(find ./ | egrep "\/body\/(.*)\.(htm|html)$"); do
	FILE_DIR=`dirname "$i"`
	FIME_NAME=`echo $i | sed "s:$FILE_DIR\/::g"`
	echo "Limpiando contenido del archivo $FIME_NAME"
#Verificando codificación del arhivo
if file -i $i | egrep "charset=utf\-8" > /dev/null; then
	$WORKPATH/bin/tidy -config $WORKPATH/etc/tidyUTF8 -m "$i"
else
	$WORKPATH/bin/tidy -config $WORKPATH/etc/tidy -m "$i"
fi
#Quitando saltos de línea
	tr '\n\r' ' ' < $i > ${i}.bak
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
	-e 's:\(\&ndash;\|–\):\&#150;:g' \
	-e 's:\(\&mdash;\|—\):\&#151;:g' \
	-e "s:\(‘\|’\):':g" \
	-e 's:\(\&ldquo;\|\&rdquo;\|\&quot;\|“\|”\):":g' \
	-e 's:\\ &\ :\\ &amp;\ :g' \
	-e 's:µ:\&#181;:g' \
	-e 's:ª:\&ordf;:g' \
	-e 's:º:\&ordm;:g' \
	-e 's:\(\&#225;\|\á\):\&aacute;:g' \
	-e 's:\(\&#233;\|\é\):\&eacute;:g' \
	-e 's:\(\&#237;\|\í\):\&iacute;:g' \
	-e 's:\(\&#243;\|\ó\):\&oacute;:g' \
	-e 's:\(\&#250;\|\ú\):\&uacute;:g' \
	-e 's:\(\&#193;\|\Á\):\&Aacute;:g' \
	-e 's:\(\&#201;\|\É\):\&Eacute;:g' \
	-e 's:\(\&#205;\|\Í\):\&Iacute;:g' \
	-e 's:\(\&#211;\|\Ó\):\&Oacute;:g' \
	-e 's:\(\&#218;\|\Ú\):\&Uacute;:g' \
	-e 's:\(\&#226;\|\â\):\&acirc;:g' \
	-e 's:\(\&#234;\|\ê\):\&ecirc;:g' \
	-e 's:\(\&#238;\|\î\):\&icirc;:g' \
	-e 's:\(\&#244;\|\ô\):\&ocirc;:g' \
	-e 's:\(\&#251;\|\û\):\&ucirc;:g' \
	-e 's:\(\&#194;\|\Â\):\&Acirc;:g' \
	-e 's:\(\&#202;\|\Ê\):\&Ecirc;:g' \
	-e 's:\(\&#206;\|\Î\):\&Icirc;:g' \
	-e 's:\(\&#212;\|\Ô\):\&Ocirc;:g' \
	-e 's:\(\&#219;\|\Û\):\&Ucirc;:g' \
	-e 's:\(\&#224;\|\à\):\&agrave;:g' \
	-e 's:\(\&#232;\|\è\):\&egrave;:g' \
	-e 's:\(\&#236;\|\ì\):\&igrave;:g' \
	-e 's:\(\&#242;\|\ò\):\&ograve;:g' \
	-e 's:\(\&#249;\|\ù\):\&ugrave;:g' \
	-e 's:\(\&#192;\|\À\):\&Agrave;:g' \
	-e 's:\(\&#200;\|\È\):\&Egrave;:g' \
	-e 's:\(\&#204;\|\Ì\):\&Igrave;:g' \
	-e 's:\(\&#210;\|\Ò\):\&Ograve;:g' \
	-e 's:\(\&#217;\|\Ù\):\&Ugrave;:g' \
	-e 's:\(\&#228;\|\ä\):\&auml;:g' \
	-e 's:\(\&#235;\|\ë\):\&euml;:g' \
	-e 's:\(\&#239;\|\ï\):\&iuml;:g' \
	-e 's:\(\&#246;\|\ö\):\&ouml;:g' \
	-e 's:\(\&#252;\|\ü\):\&uuml;:g' \
	-e 's:\(\&#196;\|\Ä\):\&Auml;:g' \
	-e 's:\(\&#203;\|\Ë\):\&Euml;:g' \
	-e 's:\(\&#207;\|\Ï\):\&Iuml;:g' \
	-e 's:\(\&#214;\|\Ö\):\&Ouml;:g' \
	-e 's:\(\&#220;\|\Ü\):\&Uuml;:g' \
	-e 's:\(\&#227;\|\ã\):\&atilde;:g' \
	-e 's:\(\&#245;\|\õ\):\&otilde;:g' \
	-e 's:\(\&#195;\|\Ã\):\&Atilde;:g' \
	-e 's:\(\&#213;\|\Õ\):\&Otilde;:g' \
	-e 's:\(\&#241;\|\ñ\):\&ntilde;:g' \
	-e 's:\(\&#209;\|\Ñ\):\&Ntilde;:g' \
	-e 's:\æ:ae:g' \
	-e 's:\Æ:AE:g' \
	-e 's:\Œ:OE:g' \
	-e 's:\œ:oe:g' \
	-e 's:\Š:S:g' \
	-e 's:\š:s:g' \
	-e 's:\Ý:Y:g' \
	-e 's:\ý:y:g' \
	-e 's:\ß:\&#946;:g' \
	-e 's:\&#64258;:fl:g' \
	-e 's:\&#64257;:fi:g' \
	-e '/^$/d' > $i
	rm -rf ${i}.bak
#Limpiar etiquetas <font> inecesarias de acuerdo a la condición inicial
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
#Por omisión limpiamos las etiquetas <font> basura 
	sed -e 's:</\?font[^<>]*>::g' $i > ${i}.bak
	mv ${i}.bak $i
#Identando condigo HTML
	$WORKPATH/bin/tidy -config $WORKPATH/etc/tidy -m -i "$i"
#Reemplazamos etiquetas que usa tidy
	sed -e 's:\[:\&#91;:g' \
	-e 's:\]:\&#93;:g' \
	-e 's:\(\&ndash;\|–\|\&#8211;\):\&#150;:g' \
	-e 's:\(-\):\&#45;:g' \
	-e 's:\(\&mdash;\|—\|\&#8212;\):\&#151;:g' \
	-e 's:µ:\&#181;:g' \
	-e 's:\ß:\&#946;:g' \
	-e 's:\ \ \ \ :	:g' \
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
	-e 's:\&hellip;:\.\.\.:g' \
	$i > ${i}.bak
	mv ${i}.bak $i
#Por omision agregamos las etiquetas <font> estandar
	sed -e 's:<p>:<p align=\"justify\">:g' -e 's:<p[^>]*>:&<font face=\"verdana\" size=\"2\">:g' -e 's:<\/p>:<\/font><\/p>:g' $i > ${i}.bak
	mv ${i}.bak $i
#Limpiando pantalla
#	clear
done
echo "Limpieza de codigo HTML completa"
