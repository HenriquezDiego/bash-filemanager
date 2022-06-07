#!/bin/bash
var=0
opcion=0
current_path=$(pwd)
path=""
file_number=1
file=""
error=""
name=""
confirm=""

function continue(){
   echo ""
   read -t5 -p "Pulse Enter para volver al menú" key
   if [ $key==$‘\x0a’ ]
   then
   clear
   fi
   clear
}


read -sp 'Password: ' password
echo ""
clear
if [ "$password" == "Catolica10" ]; then
while [ $opcion -ne 5 ]
do
echo "********* Menu **********"
echo "[1] Listar archivos y carpetas"
echo "[2] Crear una carpeta"
echo "[3] Crear archivos"
echo "[4] Opciones con archivos"
echo "[5] Salir"
read -p "Introduce una opcion: " opcion
clear
case $opcion in
1) read -t5 -p "Ruta (${current_path}):" path
   if [ -z "$path" ]
   then
   path=$current_path
   fi
   if [ -d "$path" ]
   then
   ls -lha $path
   continue
   else
   read -t5 -p "No existe la ruta indicada ${path}. Pulse Enter para volver al menú" key
   if [ $key==$‘\x0a’ ]
   then
   clear
   fi
   fi
   ;;
 2) read -p "Nombre (${current_path}):" path
    mkdir $path && echo "Directorio creado con exito" 2> .error
    cat .error
    sleep 5
    clear
   ;; 
 3) read -p "Nombre (${current_path}):" path
    read -p "Numero de archivos (${current_path}):" file_number
    for (( i=1; i<=file_number; i++ )); 
    do
      touch $path$i
    done
    sleep 5
    clear
   ;;
 4) read -p "Nombre del archivo:" file
  if [ -f $file ]
  then
   echo "[1] Copiar el archivo"
   echo "[2] Mover el archivo"
   echo "[3] Cambiar de nombre al archivo"
   echo "[4] Borrar el archivo"
   echo "[5] Cancelar operación"
   read -p "Introduce una opcion: " opcion
     case $opcion in
     1) cp $file "${file}-copy"
        echo "El archivo se ha copiado con exito"
        sleep 2
        clear;;
     2) read -p "Ruta de destino :" path
        if [ -d "$path" ]
        then
          mv ${current_path}/$file $path/$file
          echo "El archivo se ha movido con exito"
          clear
        else
          echo "El directorio ${path} no existe"
          sleep 2
        fi
        clear;;
     3) read -p "Renombrar :" name
        mv ${current_path}/$file ${current_path}/$name;;
     4) read -p "Esta seguro que quiere eliminar el archivo? (s/n):" confirm
        case $confirm in
        [sS]* ) rm $file;;
        [nN]* ) sleep 5
        clear;;
        * ) echo "Por favor ingres S/s N/n.";;
        esac
     esac
  else
   echo "El fichero $file no existe"
   sleep 5
   clear
  fi
   ;;       
esac
done
else
echo "Password incorrecta"
sleep 2
clear
fi
