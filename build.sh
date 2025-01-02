#!/bin/bash
set -x

# Merge md files
mkdir -p build
cd build
for i in `ls -d ../ch*/*`; do
    echo $i
    cat $i/*.md >> total_res.md
    
    DIR_ASS=${i}/assets
    if [ -d "$DIR_ASS" ]; then
        cp -r $DIR_ASS .
    fi

done


# Export to pdf.
# Ref: https://tomshine.hashnode.dev/markdown-pdf
sudo apt install pandoc
