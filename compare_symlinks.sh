#!/bin/bash

FILE1="$1"  # Fichier de référence (avant)
FILE2="$2"  # Fichier à comparer (après)

if [[ ! -f "$FILE1" || ! -f "$FILE2" ]]; then
    echo "❌ Les deux fichiers doivent exister."
    echo "Usage : $0 fichier1.txt fichier2.txt"
    exit 1
fi

declare -A map1
declare -A map2

# Remplir map1 (fichier de référence)
while IFS='➜' read -r link target; do
    link=$(echo "$link" | xargs)
    target=$(echo "$target" | xargs)
    map1["$link"]="$target"
done < "$FILE1"

# Remplir map2 (fichier comparé)
while IFS='➜' read -r link target; do
    link=$(echo "$link" | xargs)
    target=$(echo "$target" | xargs)
    map2["$link"]="$target"
done < "$FILE2"

echo "🔍 Comparaison des liens symboliques :"

# Parcours de tous les liens dans le fichier de référence
for link in "${!map1[@]}"; do
    if [[ -v map2["$link"] ]]; then
        if [[ "${map1[$link]}" == "${map2[$link]}" ]]; then
            echo "✅ Identique : $link"
        else
            echo "❌ Modifié  : $link"
            echo "     Avant : ${map1[$link]}"
            echo "     Après : ${map2[$link]}"
        fi
    else
        echo "➖ Supprimé : $link"
    fi
done

# Recherche des nouveaux liens dans map2
for link in "${!map2[@]}"; do
    if [[ ! -v map1["$link"] ]]; then
        echo "➕ Ajouté   : $link ➜ ${map2[$link]}"
    fi
done

