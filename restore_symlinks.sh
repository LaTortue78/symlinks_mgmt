#!/bin/bash

# Fichier d'entrée (défaut : symlinks.txt)
INPUT="${1:-symlinks.txt}"

# Vérifie que le fichier existe
if [[ ! -f "$INPUT" ]]; then
    echo "❌ Fichier $INPUT introuvable."
    exit 1
fi

while IFS='➜' read -r link target; do
    # Nettoyage des espaces
    link=$(echo "$link" | xargs)
    target=$(echo "$target" | xargs)

    # Vérifie que la cible existe
    if [[ ! -e "$target" ]]; then
        echo "⚠️  Cible manquante ignorée : $link → $target"
        continue
    fi

    # Si le lien existe déjà, vérifier s'il pointe vers la bonne cible
    if [[ -L "$link" && "$(readlink -f "$link")" == "$(readlink -f "$target")" ]]; then
        echo "✅ Lien déjà correct : $link"
        continue
    fi


    # Création / mise à jour du lien
    ln -sf "$target" "$link"
    echo "🔁 Lien restauré : $link → $target"

done < "$INPUT"

