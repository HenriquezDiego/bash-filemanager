#!/bin/bash
var=0
opcion=0
current_path=$(pwd)
path=""
file_number=1
error=""
while [ $opcion -ne 5 ]
do
echo "[1] Listar archivos y carpetas"
echo "[2] Crear una carpeta"
echo "[3] Crear archivos"
echo "[4] Opciones con archivos"
echo "[5] Salir"
read -p "Introduce una opcion: " opcion
clear
case $opcion in
1) read -p "Ruta (${current_path}):" path
   ls -la $path
   sleep 5
   clear
   ;;
 2) read -p "Nombre (${current_path}):" path
    mkdir $path && echo "Archivo creado con exito" 2> .error
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
 4) read -p "Archivo (${current_path}):" path
   ls -la $path
   sleep 5
   clear
   ;;       
esac
done

