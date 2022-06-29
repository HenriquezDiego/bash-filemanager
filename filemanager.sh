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
         if [ ! -d "$path" ]
         then
            mkdir $path
            echo "El directorio se ha creado correctamente"
            continue
         else
            echo "Ya existe un directorio con ese nombre"
            continue
         fi;; 
    3) read -p "Nombre (${current_path}):" path
       read -p "Numero de archivos (${current_path}):" file_number
         for (( i=1; i<=file_number; i++ )); 
         do
            touch $path$i
         done
            echo "Archivos creados con exito"
         continue;;
    4) read -p "Nombre del archivo:" file
       if [ -f $file ]
       then
       subopcion=0
         while [ $subopcion -ne 5 ]
         do
            clear
            echo "[1] Copiar el archivo (${file})"
            echo "[2] Mover el archivo (${file})"
            echo "[3] Cambiar de nombre al archivo (${file})"
            echo "[4] Borrar el archivo (${file})"
            echo "[5] Cancelar operación"
            read -p "Introduce una opcion: " subopcion
            case $subopcion in
            1) read -p "Ruta de destino (${current_path}):" path
               if [ -z "$path" ]
               then
                  path=$current_path
               fi
               if [ -d "$path" ]
               then 
                  cp $file "${path}/${file}-copy"
                  echo "El archivo se ha copiado con exito"
                  continue
               else
                  echo "La ruta de destino no existe"
                  continue
               fi;;
            2) read -p "Ruta de destino :" path
               if [ -d "$path" ]
               then
                 mv ${current_path}/$file $path/$file
                 echo "El archivo se ha movido con exito"
                 break
               else
                 echo "El directorio ${path} no existe"
                 continue
               fi
               clear;;
            3) read -p "Renombrar (${current_path}/${file}):" name
                  mv $file $name
                  file=$name
                  echo "El archivo se ha renombrado con éxito"
                  continue;;
            4) read -p "Esta seguro que quiere eliminar el archivo? (s/n):" confirm
                  case $confirm in
                  [sS]* ) 
                  rm $file
                  echo "Archivo eliminado con éxito"
                  break;;
                  [nN]* ) continue;;
                  * ) echo "Por favor ingres S/s N/n."
                  esac;;
             5) break;;  
            esac
          done
            continue  
      else
         echo "El fichero $file no existe"
         continue
     fi     
   esac
done
else
   echo "Password incorrecta"
   sleep 1
   clear
fi
# this is a test