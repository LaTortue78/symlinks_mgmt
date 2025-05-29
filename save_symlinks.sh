#!/bin/bash

# Répertoire racine à explorer (défaut : projet)
ROOT="${1:-projet}"

# Fichier de sortie (défaut : symlinks.txt)
OUT="${2:-symlinks.txt}"

# Vide le fichier de sortie s’il existe
> "$OUT"

# Parcours récursif de tous les liens symboliques
find "$ROOT" -type l | while read -r link; do
    # Lien absolu (source)
    abs_link=$(realpath -s "$link")

    # Cible absolue résolue
    abs_target=$(readlink -f "$link")

    # Si lien cassé ou auto-référent, ignorer
    if [[ -z "$abs_target" ]] || [[ "$abs_link" == "$abs_target" ]]; then
        echo "⚠️  Lien ignoré : $abs_link ➜ $abs_target" >&2
        continue
    fi

    # Sauvegarde dans le fichier
    echo "$abs_link ➜ $abs_target" >> "$OUT"
done

# Protéger le fichier contre l'édition
chmod 444 "$OUT"

echo "📄 Liens symboliques sauvegardés dans : $OUT"

